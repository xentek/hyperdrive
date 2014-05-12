module Hyperdrive
  module Errors
    class JSONParseError < HTTPError
      def initialize
        @http_status_code = 400
        @message = 'The JSON sent in the request cannot be parsed due to bad syntax.'
      end
    end
  end
end

