module Hyperdrive
  module Errors
    class NotImplemented < HTTPError
      def initialize(request_method)
        @message = "The server either does not recognise the request method (#{request_method}), or it lacks the ability to fulfill the request."
        @http_status_code = 501
      end
    end
  end
end
