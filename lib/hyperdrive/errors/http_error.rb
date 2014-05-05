# encoding: utf-8

module Hyperdrive
  module Errors 
    class HTTPError < RuntimeError
      def message
        'Unknown Error.'
      end

      def http_status_code
        500
      end
    end
  end
end
