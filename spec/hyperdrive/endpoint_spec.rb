# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Endpoint do
  def app
    Hyperdrive::Endpoint
  end

  before do
    sample_api
  end

  after do
    hyperdrive.send(:reset!)
  end

  it "responds to requests" do
    get '/', {}, default_rack_env(hyperdrive.resources[:thing])
    last_response.successful?.must_equal true
  end
end
