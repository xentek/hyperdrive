# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Charset do
  def app
    inner_app = ->(env) { [200, {}, [env['hyperdrive.params']]] }
    Hyperdrive::Middleware::Charset.new(inner_app)
  end

  before do
    @env = default_rack_env(default_resource).merge('hyperdrive.params' => {})
    @env.merge!('REQUEST_METHOD' => 'POST')
    @params = { id: '1001', name: 'John Connor'.encode('ASCII-8BIT') }
  end

  it "will enforce accept-charset encoding on param values" do
    post '/', @params, @env.merge('hyperdrive.params' => @params)
    last_response.body.must_equal "{:id=>\"1001\", :name=>\"John Connor\"}"
  end

  it "will enforce a default charset if accept-charset is not present" do
    @env.delete('HTTP_ACCEPT_CHARSET')
    post '/', @params, @env.merge('hyperdrive.params' => @params)
    last_response.body.must_equal "{:id=>\"1001\", :name=>\"John Connor\"}"
  end
end
