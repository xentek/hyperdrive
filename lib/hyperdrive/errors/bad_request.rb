module Hyperdrive
  module Errors
    class BadRequest < HTTPError
      def initialize
        @http_status_code = 400
        @message = 'The request cannot be fulfilled due to bad syntax.'
      end
    end
  end
end
