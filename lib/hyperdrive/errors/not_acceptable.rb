# encoding: utf-8

module Hyperdrive
  module Errors
    class NotAcceptable < HTTPError
      def initialize(http_accept)
        @message = "This resource is not capable of generating content in the format requested by the Accept headers (#{http_accept})."
        @http_status_code = 406
      end
    end
  end
end
