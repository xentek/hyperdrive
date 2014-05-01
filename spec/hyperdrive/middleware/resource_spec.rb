# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Resource do
  def app
    inner_app = ->(env) { [200, {}, [env['hyperdrive.resource'].namespace]] }
    Hyperdrive::Middleware::Resource.new(inner_app, default_resource)
  end

  it "adds the requested resource to rack's env" do
    get '/'
    last_response.body.must_equal "things"
  end
end
