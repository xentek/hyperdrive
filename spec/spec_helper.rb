# encoding: utf-8

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
        'HTTP_ACCEPT_CHARSET' => 'UTF-8',
        'HTTP_ACCEPT' => 'application/vnd.hyperdrive.things+hal+json;q=0.8, application/json;q=1',
        'HTTP_ACCEPT_LANGUAGE' => 'en',
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
          
          request(:get) do
            'ok'
          end
        end
      end
    end
  end
end
include Hyperdrive::TestData
