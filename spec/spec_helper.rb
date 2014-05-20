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
require 'mocha/mini_test'
require 'minitest/autorun'
require "minitest-spec-context"
require 'minitest/reporters'

#  all systems go
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
include Rack::Test::Methods

module Hyperdrive
  module TestData
    def default_rack_env(resource = nil)
      default_env = {
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
        'QUERY_STRING' => 'id=1001'
      }
      default_env.merge!('hyperdrive.accept' => Rack::Accept::MediaType.new(default_env['HTTP_ACCEPT']))
      default_env.merge!('hyperdrive.resource' => resource) if resource
      default_env
    end

    def default_resource
      resource = Hyperdrive::Resource.new(:thing, { vendor: 'hyperdrive', media_types: ['hal+json', 'json'] })
      resource.register_request_handler(:get, Proc.new { |env| }, 'v1')
      resource.register_filter(:parent_id, '', required: true)
      resource
    end

    def default_filter
      Hyperdrive::Filter.new(:parent_id, 'Parent Identifier', required: true, constraints: 'Must be a valid BSON Object ID.')
    end

    def default_param
      Hyperdrive::Param.new(:id, 'Identifier', required: %w(PUT PATCH DELETE), constraints: 'Must be a valid BSON Object ID.')
    end

    def sample_api
      hyperdrive do
        resource(:thing) do
          name 'Thing Resource'
          description 'Description of Thing Resource'

          param :name, '50 Chars or less', required: true
          filter :parent_id, 'Parent ID of Thing', required: true

          before(:get) do
            @headers.merge!('X-Resource' => resource.name)
          end

          request(:get) do
            'ok'
          end

          request(:post) do
            'ok'
          end

          request(:put) do
            'ok'
          end

          request(:patch) do
            'ok'
          end

          request(:delete) do
            ''
          end
        end
      end
    end
  end
end
include Hyperdrive::TestData
