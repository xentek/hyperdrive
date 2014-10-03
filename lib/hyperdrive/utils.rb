# encoding: utf-8

module Hyperdrive
  module Utils
    def self.sanitize_keys(keys_to_keep, hash)
      Hash[hash.select do |key, value|
        keys_to_keep.include? key
      end]
    end

    def self.symbolize_keys(hash)
      hash.inject({}) do |result, (key, value)|
       result.merge!(Hash[
          case key
          when String then key.to_sym
          else key
          end,
          case value
          when Hash then symbolize_keys(value)
          when Array then value.map! { |v| v.is_a?(Hash) ? symbolize_keys(v) : v } ; value
          else value
          end
        ])
      end
    end

    def self.enforce_charset!(charset, params)
      encoding = charset.value == '*' ? 'UTF-8' : find_encoding(charset.value)
      params.each_value do |value|
        value.encode!(encoding) if value.is_a? String
      end
    end

    private

    def self.find_encoding(charset_value)
      begin
        Encoding.find(charset_value)
      rescue
        raise Hyperdrive::Errors::NotAcceptable.new(charset_value)
      end
    end
  end
end
