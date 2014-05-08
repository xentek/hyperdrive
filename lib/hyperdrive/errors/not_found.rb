module Hyperdrive
  module Errors
    class NotFound < HTTPError
      def initialize
        @message = 'The requested resource could not be found.'
        @http_status_code = 404
      end
    end
  end
end
