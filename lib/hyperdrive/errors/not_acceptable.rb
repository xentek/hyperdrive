module Hyperdrive
  module Errors
    class NotAcceptable < HTTPError
      def initialize(http_accept)
        @http_accept = http_accept
      end

      def message
        "This resource is not capable of generating content in the format requested by the Accept headers (#{@http_accept})."
      end

      def http_status_code
        406
      end
    end
  end
end

