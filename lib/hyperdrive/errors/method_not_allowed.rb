module Hyperdrive
  module Errors
    class MethodNotAllowed < HTTPError
      def initialize(request_method)
        @request_method = request_method
        @message = "#{request_method.upcase} requests are not supported by this resource."
        @http_status_code = 405
      end
    end
  end
end
