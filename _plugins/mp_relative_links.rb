# Source: https://github.com/jekyll/jekyll/commit/76b55f814670968e1a6836d1933ab42f8654497c

module JekyllRelativeLinks
  class Generator
    def path_from_root(relative_path, url_base)
      relative_path.sub!(%r{\A/}, '') unless relative_path.start_with? '/~'
      absolute_path = File.expand_path(relative_path, url_base)
      absolute_path.sub(%r{\A#{Regexp.escape(Dir.pwd)}/}, '')
    end
  end
end
