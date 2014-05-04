# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Resource do
  before do
    hyperdrive do
      resource(:thing) do
        name 'Thing Resource'
        description 'Thing Description'
        param :name, 'Thing Name'
        filter :parent_id, "Parent ID"
        request(:get) do
          'ok'
        end
      end
    end
  end

  after do
    hyperdrive.send(:reset!)
  end

  it "sets the name of the resource" do
    hyperdrive.resources[:thing].name.must_equal 'Thing Resource'
  end

  it "sets the description of the resource" do
    hyperdrive.resources[:thing].description.must_equal 'Thing Description'
  end

  it "registers a param for the resource" do
    hyperdrive.resources[:thing].params[:name].description.must_equal "Thing Name"
  end

  it "registers a filter for the resource" do
    hyperdrive.resources[:thing].filters[:parent_id].description.must_equal "Parent ID"
  end

  it "defines how requests are handled" do
    hyperdrive.resources[:thing].request_handlers[:get]['v1'].must_be_instance_of Hyperdrive::RequestHandler
  end

  it "throws an error if request method is unknown" do 
    bad_resource = -> { hyperdrive { resource(:thing) { request(:verb) } } }
    bad_resource.must_raise Hyperdrive::Errors::DSL::UnknownArgument
  end
end
