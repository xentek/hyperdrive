# encoding: utf-8

# bootstrap the environment
ENV['RACK_ENV'] = 'test'
lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

# test coverage
require 'coveralls'
require 'rubinius/coverage' if RUBY_ENBGINE == 'rubinius'
Coveralls.wear!

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
