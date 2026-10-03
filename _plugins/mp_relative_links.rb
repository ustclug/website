module JekyllRelativeLinks
  module PreserveUserLinks
    def path_from_root(relative_path, url_base)
      # Keep legacy /~user URLs from expanding into local home directories.
      return relative_path if relative_path.start_with? '/~'

      super
    end
  end

  # jekyll-relative-links 0.9 moved path resolution out of Generator.
  if const_defined?(:Resolver, false)
    Resolver.singleton_class.prepend(PreserveUserLinks)
  else
    Generator.prepend(PreserveUserLinks)
  end
end
