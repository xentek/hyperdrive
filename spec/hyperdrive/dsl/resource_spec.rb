# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Resource do
  #it "sets the name of the endpoint" do
    #hyperdrive do
      #resource(:thing) do
        #name "Thing Resource"
      #end
    #end.resources[:thing].name.must_equal 'Thing Resource'
  #end

  #it "describes the endpoint" do
    #hyperdrive do
      #resource(:thing) do
        #desc "Thing Description"
      #end
    #end.resources[:thing].desc.must_equal 'Thing Description'
  #end

  #it "registers an allowed param on a resource" do
    #hyperdrive do
      #resource(:thing) do
        #param :name, "Thing's Name"
      #end
    #end.resources[:thing].allowed_params[:name][:desc].must_equal "Thing's Name"
  #end

  #it "registers an allowed param on a resource" do
    #hyperdrive do
      #resource(:thing) do
        #filter :parent_id, "Thing's Parent ID"
      #end
    #end.resources[:thing].filters[:parent_id][:desc].must_equal "Thing's Parent ID"
  #end

  #it "defines how requests are handled" do
    #hyperdrive do
      #resource(:thing) do
        #request(:get) do
          #'ok'
        #end
      #end
    #end.resources[:thing].request_handlers[:get]['v1'].call(default_rack_env).must_equal 'ok'
  #end

  #it "raises an exception if request method argument is unknown" do
    #proc do
      #hyperdrive do
        #resource(:thing) do
          #request(:verb)
        #end
      #end
    #end.must_raise Hyperdrive::Errors::DSL::UnknownArgument
  #end
end
