# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Resource do
  
  it "sets the name of the endpoint" do
    hyperdrive do
      resource(:thing) do
        name "Thing Resource"
      end
    end.resources[:thing].name.must_equal 'Thing Resource'
  end

  it "describes the endpoint" do
    hyperdrive do
      resource(:thing) do
        desc "Thing Description"
      end
    end.resources[:thing].desc.must_equal 'Thing Description'
  end


  it "registers an allowed param on a resource" do
    hyperdrive do
      resource(:thing) do
        param :name, "Thing's Name"
      end
    end.resources[:thing].allowed_params[:name][:desc].must_equal "Thing's Name"
  end

  it "registers an allowed param on a resource" do
    hyperdrive do
      resource(:thing) do
        filter :parent_id, "Thing's Parent ID"
      end
    end.resources[:thing].filters[:parent_id][:desc].must_equal "Thing's Parent ID"
  end
end
