# encoding: utf-8

module Hyperdrive
  module Instrumenters
    class Memory
      Event = Struct.new(:name, :payload, :result)

      attr_reader :events

      def initialize
        @events = []
      end

      def instrument(name, payload = {})
        result = if block_given?
          yield payload
        else
          payload
        end

        @events << Event.new(name, payload, result)

        result
      end
    end
  end
end
