module Hyperdrive
  module Values
    def self.request_methods
      %w(GET HEAD OPTIONS POST PUT PATCH DELETE).freeze
    end

    def self.request_methods_symbol_map
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

    def self.request_methods_string_map
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
