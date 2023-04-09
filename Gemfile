source 'https://rubygems.org/'

gem 'jekyll', '~> 4.2'
gem 'minimal-mistakes-jekyll', '~> 4.0', '>= 4.24'
gem 'liquid-c', '~> 4.0'

if ENV['LSI'] == 'true'
  gem 'classifier-reborn'

  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.0.0')
    gem 'gsl', git: 'https://github.com/SciRuby/rb-gsl.git', ref: '103a3e1'
  else
    gem 'gsl'
  end
end

group :jekyll_plugins do
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
  gem 'jekyll-last-modified', '>= 1.0.3'
  gem 'jekyll-assets'
  gem 'jekyll-archives', '>= 2.2.1'
  gem 'jekyll-paginate-v2', '>= 3.0.0'
  gem 'jekyll-algolia'
end
