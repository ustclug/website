module JekyllRelativeLinks
  class Generator
    def path_from_root(relative_path, url_base)
      relative_path.sub!(%r{\A/}, '') unless relative_path.start_with? '/~'
      absolute_path = File.expand_path(relative_path, url_base)
      absolute_path.sub(%r{\A#{Regexp.escape(Dir.pwd)}/}, '')
    end
  end
end
