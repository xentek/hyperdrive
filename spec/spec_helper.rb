# encoding: utf-8

# bootstrap the environment
ENV['RACK_ENV'] = 'test'
lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

# test coverage
if ENV['TRAVIS']
  require 'coveralls'
  require 'rubinius/coverage' if RUBY_ENGINE == 'rubinius'
  Coveralls.wear!
end

# require dependencies
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'])

# our humble test subject
require 'hyperdrive'

# Fire up the BDD Stack
require 'minitest/autorun'
require "minitest-spec-context"
require 'minitest/reporters'

#  all systems go
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
#include Rack::Test::Methods

def sample_api
  hyperdrive do
    resource(:thing) do
      name 'Thing Resource'
      desc 'Description of Thing Resource'

      param :name, '50 Chars or less' 
      param :start_date, 'Format: YYYY-MM-DD', required: false
      param :end_date, 'Format: YYYY-MM-DD', required: false

      filter :start_date, 'Format: YYYY-MM-DD'
      filter :end_date, 'Format: YYYY-MM-DD'
      filter :parent_id, 'Parent ID of Thing', required: true
    end
  end
end