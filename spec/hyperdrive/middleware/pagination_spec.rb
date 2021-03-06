# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Pagination do
  def app
    inner_app = ->(env) { [200, {}, [[env['hyperdrive.page'],env['hyperdrive.per_page']].join(',')]] }
    Hyperdrive::Middleware::Pagination.new(inner_app)
  end

  after do
    hyperdrive.send(:reset!)
  end
  
  it "sets default values for page and per_page" do
    get '/', {}
    last_response.body.must_equal '1,20'
  end

  it "sets page to 1 if value is less than 1" do
    get '/', { 'page' => '' }
    last_response.body.must_equal '1,20'
  end

  it "returns page value if supplied" do
    get '/', { 'page' => '2' }
    last_response.body.must_equal '2,20'
  end

  it "returns per_page value if supplied" do
    get '/', { 'per_page' => 42 }
    last_response.body.must_equal '1,42'
  end

  it "uses configured per_page value if per_page is not supplied" do
    hyperdrive.config[:per_page] = 13
    get '/', {}
    last_response.body.must_equal '1,13'    
  end

  it "sets per_page to 20 if value is 0" do
    get '/', { 'per_page' => '' }
    last_response.body.must_equal '1,20'
  end
end
