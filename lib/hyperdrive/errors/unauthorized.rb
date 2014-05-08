module Hyperdrive
  module Errors
    class Unauthorized < HTTPError
      def initialize
        @message = 'The request requires user authentication.'
        @http_status_code = 401
      end
    end
  end
end
