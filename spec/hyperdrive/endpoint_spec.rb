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

  it "can raise an HTTPError" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          error(418, "I'M A TEAPOT")
        end
      end
    end
    ->{ get '/', {}, default_rack_env(hyperdrive.resources[:thing]) }.must_raise Hyperdrive::Errors::HTTPError
  end
end
