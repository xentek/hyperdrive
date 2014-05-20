# encoding: utf-8

module Hyperdrive
  module Instrumenters
    class Noop
      def self.instrument(name, payload = {})
        if block_given?
          yield payload
        else
          payload
        end
      end
    end
  end
end
