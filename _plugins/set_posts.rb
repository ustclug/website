Jekyll::Hooks.register :site, :post_read do |site|
  c = site.collections
  c['posts'].docs.concat c['news'].docs
  c['posts'].docs.concat c['planet'].docs
end
