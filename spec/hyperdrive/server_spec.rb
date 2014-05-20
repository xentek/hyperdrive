# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Server do
  def app
    Hyperdrive::Server
  end

  before do
    sample_api
  end

  after do
    hyperdrive.send(:reset!)
  end

  it "responds to GET requests successfully" do
    get '/things', { parent_id: 42 }, default_hyperdrive_env
    last_response.successful?.must_equal true
  end

  it "responds to HEAD requests successfully" do
    head '/things', { parent_id: 42 }, default_hyperdrive_env
    last_response.successful?.must_equal true
  end

  it "responds to OPTIONS requests successfully" do
    options '/things', {}, default_hyperdrive_env
    last_response.successful?.must_equal true
  end

  it "responds to POST requests successfully" do
    post '/things', { name: 'bender' }, default_hyperdrive_env
    last_response.successful?.must_equal true
  end

  it "responds to PUT requests successfully" do
    put '/things', { id: 1, name: 'bender' }, default_hyperdrive_env
    last_response.successful?.must_equal true
  end

  it "responds to PATCH requests successfully" do
    patch '/things', { id: 1, name: 'bender' }, default_hyperdrive_env
    last_response.successful?.must_equal true
  end

  it "responds to DELETE requests successfully" do
    delete '/things', { id: 1 }, default_hyperdrive_env
    last_response.successful?.must_equal true
  end
end
