# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::ParseJSONBody do
  def app
    inner_app = ->(env) { [200,{},[env['rack.request.form_input']]] }
    Hyperdrive::Middleware::ParseJSONBody.new(inner_app)
  end

  before do
    @json = '{"ok":"player","nested":{"key":"value"}}'
    @headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  it "parses json input" do
    post '/', @json, @headers
    last_response.body.must_equal "ok=player&nested=%7B%22key%22%3D%3E%22value%22%7D"
  end

  it "overrides values in the query string with those in the json input" do
    post '/?ok=playa', @json, @headers
    last_response.body.must_equal "ok=player&nested=%7B%22key%22%3D%3E%22value%22%7D"
  end

  it "throws an error if the json can't be parsed" do
    -> { post '/', "{ badjson }", @headers }.must_raise Hyperdrive::Errors::JSONParseError
  end
end
