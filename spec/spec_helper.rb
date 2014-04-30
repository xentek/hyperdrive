# encoding: utf-8

require 'rubinius/coverage' if RUBY_ENGINE == 'rubinius'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

# bootstrap the environment
ENV['RACK_ENV'] = 'test'
lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

# require dependencies
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'])

# our humble test subject
require 'hyperdrive'

# Fire up the BDD Stack
require 'rack/test'
require 'minitest/autorun'
require "minitest-spec-context"
require 'minitest/reporters'

#  all systems go
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
include Rack::Test::Methods

module Hyperdrive
  module TestData
    def default_rack_env
      {
        "rack.version" => Rack::VERSION,
        "rack.input" => StringIO.new,
        "rack.errors" => StringIO.new,
        "rack.multithread" => true,
        "rack.multiprocess" => true,
        "rack.run_once" => false,
        'REQUEST_METHOD' => 'GET',
        'QUERY_STRING' => 'id=player'
      }
    end

    def sample_api
      hyperdrive do
        resource(:thing) do
          name 'Thing Resource'
          desc 'Description of Thing Resource'

          param :name, '50 Chars or less', required: true

          filter :parent_id, 'Parent ID of Thing', required: true
        end
      end
    end
  end
end
include Hyperdrive::TestData
