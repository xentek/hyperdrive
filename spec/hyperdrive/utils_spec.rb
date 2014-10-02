# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Utils do
  context '.sanitize_keys' do
    before do
      @subject = Hyperdrive::Utils.sanitize_keys([:keep], { keep: 'this', remove: 'that' })
    end

    it "removes keys that were specified from the given hash" do
      @subject.key?(:remove).must_equal false
    end

    it "keeps keys that were not specified from the given hash" do
      @subject.key?(:keep).must_equal true
    end
  end

  context '.symbolize_keys' do
    before do
      @hash = { :symbol => 'symbol', 'string' => 'cheese', 'collection' => [{'skylanders' => 155}], 'map' => { 'oceans' => 'blue' } }
      @subject = Hyperdrive::Utils.symbolize_keys(@hash)
    end

    it "can symbolize the keys of a hash" do
      @subject[:string].must_equal 'cheese'
    end

    it "doesn't symbolize keys that aren't a string" do
      @subject[:symbol].must_equal 'symbol'
    end

    it "can symbolize the keys of nested hashes" do
      @subject[:map][:oceans].must_equal 'blue'
    end

    it "can symbolize the keys of arrays of hashes" do
      @subject[:collection].first[:skylanders].must_equal 155
    end
  end

  context '.enforce_charset!' do
    before do
      @params = { id: '1001', name: 'John Connor'.encode('ASCII-8BIT') }
    end

    it 'enforces a specific encoding' do
      encoding = Rack::Accept::Charset.new('ISO-8859-1')
      Hyperdrive::Utils.enforce_charset!(encoding, @params)
      @params[:name].encoding.must_equal Encoding.find('ISO-8859-1')
    end

    it 'enforces a default encoding' do
      encoding = Rack::Accept::Charset.new('*')
      Hyperdrive::Utils.enforce_charset!(encoding, @params)
      @params[:name].encoding.must_equal Encoding.find('UTF-8')
    end

    it 'raises an exception for an invalid encoding' do
      encoding = Rack::Accept::Charset.new('nonsense')
      -> { Hyperdrive::Utils.enforce_charset!(encoding, @params) }
        .must_raise Hyperdrive::Errors::NotAcceptable
    end
  end
end
