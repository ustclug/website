Jekyll::Hooks.register :site, :post_read do |site|
  c = site.collections
  c['posts'].docs.concat c['news'].docs
  c['posts'].docs.concat c['planet'].docs
end

# Also monkey-patch `jekyll doctor` command
module Jekyll
  module Commands
    class Doctor
      class << self
        def conflicting_urls(site)
          conflicting_urls = false
          destination_map(site).each do |dest, paths|
            next unless paths.uniq.size > 1

            conflicting_urls = true
            Jekyll.logger.warn "Conflict:",
                               "The following destination is shared by multiple files."
            Jekyll.logger.warn "", "The written file may end up with unexpected contents."
            Jekyll.logger.warn "", dest.to_s.cyan
            paths.each { |path| Jekyll.logger.warn "", " - #{path}" }
            Jekyll.logger.warn ""
          end
          conflicting_urls
        end
      end
    end
  end
end
