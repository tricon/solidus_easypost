source 'https://rubygems.org'

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem 'solidus', github: 'solidusio/solidus', branch: branch
gem 'rails', '< 5.1' # hack for broken bundler dependency resolution
gem 'solidus_auth_devise'

gem 'pg'
gem 'mysql2'

gemspec
