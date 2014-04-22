# encoding: utf-8

module Hyperdrive
  module Errors 
    class HTTPError < RuntimeError
      def http_status_code
        500
      end
    end
  end
end
