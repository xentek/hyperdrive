# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::RequiredParams do
  def app
    inner_app = ->(env) { [200, {}, [env['hyperdrive.params'][:id]]] }
    Hyperdrive::Middleware::RequiredParams.new(inner_app)
  end

  context "with required" do
    context "GET" do
      before do
        hyperdrive_env = {
          'REQUEST_METHOD'      => 'GET',
          'hyperdrive.resource' => sample_api.resources.values.first,
          'hyperdrive.params'   => { parent_id: '1000' }
        }
        @env = default_rack_env.merge(hyperdrive_env)
      end

      it "responds successfully if required is present" do
        status, headers, body = app.call(@env)
        status.must_equal 200
      end
    end

    context "non-GET" do
      before do
        hyperdrive_env = {
          'REQUEST_METHOD'      => 'PUT',
          'hyperdrive.resource' => sample_api.resources.values.first,
          'hyperdrive.params'   => { id: '1001', name: 'yoda' }
        }
        @env = default_rack_env.merge(hyperdrive_env)
      end

      it "responds successfully if required params are present" do
        app.call(@env).first.must_equal 200
      end
    end
  end

  context "without required" do
    context "GET" do
      before do
        hyperdrive_env = {
          'REQUEST_METHOD'      => 'GET',
          'hyperdrive.resource' => sample_api.resources.values.first,
          'hyperdrive.params'   => {}
        }
        @env = default_rack_env.merge(hyperdrive_env)
      end

      it "raises an error if required filter is missing" do
        ->{ app.call(@env) }.must_raise Hyperdrive::Errors::MissingRequiredParam
      end
    end

    context "non-GET" do
      before do
        hyperdrive_env = {
          'REQUEST_METHOD'      => 'PUT',
          'hyperdrive.resource' => sample_api.resources.values.first,
          'hyperdrive.params'   => {}
        }
        @env = default_rack_env.merge(hyperdrive_env)
      end

      it "raises if required param is missing" do
        ->{ app.call(@env) }.must_raise Hyperdrive::Errors::MissingRequiredParam
      end
    end
  end
end
