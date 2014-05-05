source 'https://rubygems.org'
gemspec

group :development, :test do
  gem 'oj' unless defined?(JRUBY_VERSION)
end

group :development do
  gem 'gem-release', require: false
  gem 'pry', require: false
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
  gem 'rubinius-coverage', require: false, platforms: :rbx
  gem 'codeclimate-test-reporter', require: false
end
