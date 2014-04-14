# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Main do
  before do
    @hyperdrive = hyperdrive {}
  end

  it "creates a new instance of hyperdrive" do
    @hyperdrive.must_be_instance_of ::Hyperdrive::DSL::Main
  end

  it "registers a resource" do
    hyperdrive do
      resource(:thing) {}
    end
    @hyperdrive.resources[:thing].must_be_instance_of ::Hyperdrive::Resource
  end

  it "registers an allowed param on a resource" do
    hyperdrive do
      resource(:thing) do
        param :name, "Thing's Name"
      end
    end
    @hyperdrive.resources[:thing].allowed_params[:name][:desc].must_equal "Thing's Name"
  end

  it "registers an allowed param on a resource" do
    hyperdrive do
      resource(:thing) do
        filter :parent_id, "Thing's Parent ID"
      end
    end
    @hyperdrive.resources[:thing].filters[:parent_id][:desc].must_equal "Thing's Parent ID"
  end  
end
