# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::EnforceEncoding do

  def app
    inner_app = ->(env) { [200, {}, [env['hyperdrive.params']]] }
    Hyperdrive::Middleware::EnforceEncoding.new(inner_app)
  end

  before do
    @env = default_rack_env(default_resource).merge('hyperdrive.params' => {})
    @env.merge!('REQUEST_METHOD' => 'POST')
    @params = { id: '1001', name: 'John Connor'.encode('UTF-16') }
  end

  it "will enforce UTF-8 encoding on param values" do
    post '/', @params, @env.merge('hyperdrive.params' => @params)
    last_response.body.must_equal "{:id=>\"1001\", :name=>\"John Connor\"}"
  end
end
