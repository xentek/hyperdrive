source 'https://rubygems.org'
gemspec

if ENV['TRAVIS']
  gem 'coveralls', require: false

  platforms :rbx do
    gem 'rubinius-coverage', require: false
  end
end

group :development do
  gem 'gem-release', require: false
end

group :test, :rake do
  gem 'bundler'
end

group :rake do
  gem 'rake'
end

group :test do
  gem 'minitest', require: false
  gem 'minitest-spec-context', require: false
  gem 'minitest-reporters', require: false
  gem 'rack-test', require: false
end
