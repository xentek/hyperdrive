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

  it "runs before callbacks" do
    get '/', {}, default_rack_env(hyperdrive.resources[:thing])
    last_response.headers['X-Resource'].must_equal 'Thing Resource'
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

  it "can call the instrumenter" do
    hyperdrive do
      instrumenter Hyperdrive::Instrumenters::Memory.new
      resource(:thing) do
        request(:get) do
          instrument('requests.GET', '1')
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing])
    hyperdrive.config[:instrumenter].events.size.must_be :>, 0
  end

  it "returns true if media type ends in json" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          json?.to_s
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/json')
    last_response.body.must_equal 'true'
  end

  it "returns false if media type does not ends in json" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          json?.to_s
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/xml')
    last_response.body.must_equal 'false'
  end

  it "returns true if media type ends in xml" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          xml?.to_s
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/xml')
    last_response.body.must_equal 'true'
  end

  it "returns false if media type does not ends in xml" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          xml?.to_s
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/json')
    last_response.body.must_equal 'false'
  end

  it "returns version if media type contains a version" do
    hyperdrive do
      resource(:thing) do
        request(:get, 'v2') do
          requested_version.to_s
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/vnd.hyperdrive.things.v2+json')
    last_response.body.must_equal 'v2'
  end

  it "returns latest version if media type does not contain a version" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          requested_version.to_s
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/vnd.hyperdrive.things+json')
    last_response.body.must_equal 'v1'
  end

  it "renders Arrays as json if media type is json" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          []
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/vnd.hyperdrive.things+json')
    last_response.body.must_equal '[]'
  end

  it "throws an error if media type is not json and response is an Array" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          []
        end
      end
    end
    ->{ get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge({'hyperdrive.media_type' => 'application/xml' }) }.must_raise Hyperdrive::Errors::NoResponse
  end

  it "renders Hashes as json if media type is json" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          {}
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/vnd.hyperdrive.things+json')
    last_response.body.must_equal '{}'
  end

  it "throws an error if media type is not json and response is a Hash" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          {}
        end
      end
    end
    ->{ get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge({'hyperdrive.media_type' => 'application/xml' }) }.must_raise Hyperdrive::Errors::NoResponse
  end

  it "renders other responses as a string" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          0
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.media_type' => 'application/vnd.hyperdrive.things+json')
    last_response.body.must_equal '0'
  end

  it "returns the current page" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          page
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.page' => '2')
    last_response.body.must_equal '2'
  end

  it "returns the number of results in each page" do
    hyperdrive do
      resource(:thing) do
        request(:get) do
          per_page
        end
      end
    end
    get '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('hyperdrive.per_page' => '20')
    last_response.body.must_equal '20'
  end

  it "returns 200 when request is a GET" do
    get '/', {}, default_rack_env(hyperdrive.resources[:thing])
    last_response.status.must_equal 200
  end

  it "returns 201 when request is a POST" do
    post '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('REQUEST_METHOD' => 'POST')
    last_response.status.must_equal 201
  end

  it "returns 200 when request is a PUT" do
    put '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('REQUEST_METHOD' => 'PUT')
    last_response.status.must_equal 200
  end

  it "returns 200 when request is a PATCH" do
    patch '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('REQUEST_METHOD' => 'PATCH')
    last_response.status.must_equal 200
  end

  it "returns 200 when request is a OPTIONS" do
    options '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('REQUEST_METHOD' => 'OPTIONS')
    last_response.status.must_equal 200
  end

  it "returns 204 when request is a DELETE" do
    delete '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('REQUEST_METHOD' => 'DELETE')
    last_response.status.must_equal 204
  end

  it "returns an empty body when request is a DELETE" do
    delete '/', {}, default_rack_env(hyperdrive.resources[:thing]).merge('REQUEST_METHOD' => 'DELETE')
    last_response.body.must_equal ''
  end
end
