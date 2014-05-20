# encoding: utf-8

module Hyperdrive
  module Values
    module_function

    def definable_request_methods
      [:get, :post, :put, :patch, :delete].freeze
    end

    def supported_request_methods
      %w(GET HEAD OPTIONS POST PUT PATCH DELETE).freeze
    end

    def request_methods
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

    def http_request_methods
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

    def default_cors_options
      {
          origins: '*',
          allow_headers: 'Content-Type, Accept, Accept-Encoding, Authorization, If-None-Match',
          credentials: 'false',
          expose_headers: 'Allow, Cache-Control, Content-Language, Content-Type, ETag',
          max_age: 86400
      }.freeze
    end

    def default_config
      {
        cors: default_cors_options,
        name: 'Hyperdrive API',
        description: "v#{Hyperdrive::VERSION}",
        vendor: 'hyperdrive',
        media_types: %w(hal+json json),
        per_page: 20,
        ssl: false,
        instrumenter: Hyperdrive::Instrumenters::Noop
      }.freeze
    end

    def default_headers
      {
        'X-Powered-By' => "Hyperdrive (v#{Hyperdrive::VERSION})"
      }
    end
  end
end
