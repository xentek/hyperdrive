# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::HATEOAS do
  context 'without Resources' do
    def app
      inner_app = ->(env) { [200, {}, ['']] }
      Hyperdrive::Middleware::HATEOAS.new(inner_app)
    end

    it "throws a Not Found error" do
      ->{ get '/' }.must_raise Hyperdrive::Errors::NotFound
    end
  end

  context 'with Resources' do
    def app
      inner_app = ->(env) { [200, {}, ['']] }
      Hyperdrive::Middleware::HATEOAS.new(inner_app, { thing: default_resource })
    end

    before do
      get '/', {}, default_rack_env
    end

    it "responds successfully" do
      last_response.successful?.must_equal true
    end

    it "sets the content type" do
      last_response.headers['Content-Type'].must_equal 'application/json'
    end

    it "sets the allow header" do
      last_response['Allow'].must_equal 'GET,HEAD,OPTIONS,POST,PUT,PATCH,DELETE'
    end

    it "returns an arry of resources" do
      last_response.body.must_equal "[{\"_links\":{\"self\":{\"href\":\"/things\"}},\"id\":\"hyperdrive:things\",\"description\":null,\"methods\":[\"OPTIONS\",\"GET\",\"HEAD\"],\"params\":[{\"name\":\"id\",\"description\":\"Identifier\",\"type\":\"String\",\"constraints\":\"Required for: PUT, PATCH, DELETE. \"}],\"filters\":[{\"name\":\"id\",\"description\":\"Resource Identifier\",\"type\":\"String\",\"constraints\":\" \"},{\"name\":\"parent_id\",\"description\":\"\",\"type\":\"String\",\"constraints\":\"Required for: GET, HEAD. \"}]}]"
    end
  end
end
