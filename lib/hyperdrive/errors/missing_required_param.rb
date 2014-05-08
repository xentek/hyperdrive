module Hyperdrive
  module Errors
    class MissingRequiredParam < HTTPError
      def initialize(param, http_request_method)
        @message = "The #{param} param is required by #{http_request_method} requests."
        @http_status_code = 400
      end
    end
  end
end
