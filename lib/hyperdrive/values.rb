module Hyperdrive
  module Values
    def self.supported_request_methods
      %w(GET HEAD OPTIONS POST PUT PATCH DELETE).freeze
    end

    def self.request_methods
      {
        get:     'GET',
        head:    'HEAD',
        options: 'OPTIONS',
        post:    'POST',
        put:     'PUT',
        patch:   'PATCH',
        delete:  'DELETE'
      }.freeze
    end

    def self.http_request_methods
      {
        'GET'     => :get,
        'HEAD'    => :head,
        'OPTIONS' => :options,
        'POST'    => :post,
        'PUT'     => :put,
        'PATCH'   => :patch,
        'DELETE'  => :delete
      }.freeze
    end
  end
end
