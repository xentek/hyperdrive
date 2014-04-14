# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Resource do
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
