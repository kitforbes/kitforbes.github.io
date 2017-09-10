source 'https://rubygems.org'
ruby RUBY_VERSION

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

group :jekyll_plugins do
  gem 'github-pages', versions['github-pages']
end
