# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::SanitizeParams do
  before do
    @env = default_rack_env(default_resource)
  end

  def app
    inner_app = ->(env) { [200, {}, [env['hyperdrive.params']]] }
    Hyperdrive::Middleware::SanitizeParams.new(inner_app)
  end

  it "will sanitize filters" do
    get '/', { 'id' => '1001', 'removed' => 'me' }, @env
    last_response.body.must_equal "{:id=>\"1001\"}"
  end

  it "will sanitize params" do
    post '/', { 'id' => '1001', 'removed' => 'me' }, @env
    last_response.body.must_equal "{:id=>\"1001\"}"
  end
end
