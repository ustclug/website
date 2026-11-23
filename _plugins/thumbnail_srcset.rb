# frozen_string_literal: true

require 'set'

module Jekyll
  module ThumbnailSrcset
    DEFAULT_HOST = 'ftp.lug.ustc.edu.cn'
    DEFAULT_WIDTHS = [640, 800, 1024, 1152, 1200, 1366, 1440, 1536, 1920].freeze
    DEFAULT_FORMATS = %w[jpg jpeg png webp].freeze

    IMAGE_TAG = /<img\b(?:(?:"[^"]*"|'[^']*'|[^'">])*)>/im
    SRC_ATTRIBUTE = /(?:\A|\s)src\s*=\s*(?:(['"])(.*?)\1|([^\s>]+))/im
    SRCSET_ATTRIBUTE = /(?:\A|\s)srcset\s*=/i

    module_function

    def rewrite(html, config = {})
      host = config.fetch('host', DEFAULT_HOST).to_s
      widths = Array(config.fetch('widths', DEFAULT_WIDTHS)).filter_map do |width|
        Integer(width, exception: false)&.then { |value| value if value.positive? }
      end.uniq.sort
      formats = Array(config.fetch('formats', DEFAULT_FORMATS)).map { |format| format.to_s.downcase }.to_set
      return html if host.empty? || widths.empty? || formats.empty?

      html.gsub(IMAGE_TAG) do |tag|
        next tag if tag.match?(SRCSET_ATTRIBUTE)

        match = tag.match(SRC_ATTRIBUTE)
        next tag unless match

        src = match[2] || match[3]
        next tag unless eligible?(src, host, formats)

        candidates = widths.map { |width| "#{thumbnail_url(src, width)} #{width}w" }.join(', ')
        tag.sub(/(\s*)(\/?>)\z/, " srcset=\"#{candidates}\"\\1\\2")
      end
    end

    def eligible?(src, host, formats)
      match = src.match(%r{\Ahttps?://([^/?#]+)(/[^?#]*)?(?:[?#].*)?\z}i)
      return false unless match && match[1].casecmp?(host)

      path = match[2].to_s
      return false if path == '/.yatex' || path.start_with?('/.yatex/')

      extension = File.extname(path).delete_prefix('.').downcase
      formats.include?(extension)
    end

    def thumbnail_url(src, width)
      path, trailing = src.split(/(?=[?#])/, 2)
      extension = File.extname(path)
      "#{path}@#{width}w#{extension}#{trailing}"
    end
  end
end

rewrite_output = lambda do |document|
  config = document.site.config.fetch('thumbnail_srcset', {})
  next if config['enabled'] == false || !document.output_ext.casecmp?('.html')

  document.output = Jekyll::ThumbnailSrcset.rewrite(document.output, config)
end

Jekyll::Hooks.register :documents, :post_render, &rewrite_output
Jekyll::Hooks.register :pages, :post_render, &rewrite_output
