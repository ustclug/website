source 'https://rubygems.org/'

gem 'jekyll', '~> 4.1.1'
gem 'minimal-mistakes-jekyll', '~> 4.0', '>= 4.20.1'
gem 'liquid-c', '~> 4.0'

if ENV['LSI'] == 'true'
  gem 'classifier-reborn'
  gem 'gsl'
end

group :jekyll_plugins do
  gem 'jekyll-feed'
  gem 'jekyll-sitemap'
  gem 'jekyll-relative-links'
  gem 'jekyll-optional-front-matter'
  gem 'jekyll-titles-from-headings'
  gem 'jekyll-github-metadata' if ENV['CI'] == 'true'

  gem 'jekyll-redirect-from'
  gem 'jekyll-seo-tag'
  gem 'jekyll-include-cache'

  gem 'jekyll-data'
  gem 'jekyll-environment-variables'
  gem 'jekyll-tidy'
  gem 'jekyll-last-modified', '>= 1.0.2'
  gem 'jekyll-assets'
  gem 'jekyll-archives', '>= 2.2.1'
  gem 'jekyll-paginate-v2', '>= 3.0.0'
end
