# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::HATEOAS do
  def app
    Hyperdrive::HATEOAS
  end

  context 'without Resources' do
    it "throws a Not Found error" do
      ->{ get '/' }.must_raise Hyperdrive::Errors::NotFound
    end
  end

  context 'with Resources' do
    before do
      sample_api
      get '/', {}, default_rack_env
    end

    after do
      hyperdrive.send(:reset!)
    end

    it "responds successfully" do
      last_response.successful?.must_equal true
    end

    it "sets the content type" do
      last_response.headers['Content-Type'].must_equal 'application/json'
    end

    it "sets the allow header" do
      last_response['Allow'].must_equal 'GET, HEAD, OPTIONS'
    end

    it "responds with a description of all resources" do
      last_response.body.must_equal %Q({"_links":{"self":{"href":"/"}},"name":"Hyperdrive API","description":"v0.0.5","vendor":"hyperdrive","resources":[{"_links":{"self":{"href":"/things"}},"id":"hyperdrive:things","name":"Thing Resource","description":"Description of Thing Resource","methods":["OPTIONS","GET","HEAD"],"params":[{"name":"id","description":"Identifier","type":"String","constraints":"Required for: PUT, PATCH, DELETE. "},{"name":"name","description":"50 Chars or less","type":"String","constraints":"Required for: POST, PUT, PATCH. "}],"filters":[{"name":"id","description":"Resource Identifier","type":"String","constraints":" "},{"name":"parent_id","description":"Parent ID of Thing","type":"String","constraints":"Required for: GET, HEAD. "}],"media_types":[["application/vnd.hyperdrive.things.v1+hal+json","application/vnd.hyperdrive.things+hal+json","application/vnd.hyperdrive+hal+json","application/vnd.hyperdrive.things.v1+json","application/vnd.hyperdrive.things+json","application/vnd.hyperdrive+json"]]}]})
    end
  end
end
