# Hyperdrive

[![Gem Version](https://badge.fury.io/rb/hyperdrive.png)](http://badge.fury.io/rb/hyperdrive) [![Build Status](https://secure.travis-ci.org/styleseek/hyperdrive.png?branch=master)](https://travis-ci.org/styleseek/hyperdrive) [![Code Climate](https://codeclimate.com/github/styleseek/hyperdrive.png)](https://codeclimate.com/github/styleseek/hyperdrive) [![Test Coverage](https://codeclimate.com/github/styleseek/hyperdrive/coverage.png)](https://codeclimate.com/github/styleseek/hyperdrive) [![Dependency Status](https://gemnasium.com/styleseek/hyperdrive.png)](https://gemnasium.com/styleseek/hyperdrive)


Ruby DSL for defining self-documenting, HATEOAS™ complaint, Hypermedia endpoints.

## Installation

Add this line to your application's Gemfile:

    gem 'hyperdrive'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyperdrive

## Usage

Proposed Syntax (WIP):

```ruby
# api.rb
hyperdrive do
  resource(:thing) do
    name 'Thing Resource'
    desc 'Description of Thing Resource'

    # Register the params you want to allow in POST, PUT, PATCH,
    # and DELETE requests. The :id param is auto-registered
    # and is allowed for all requests but only required for PUT,
    # PATCH, and DELETE requests
    param :name, '50 Chars or less' # params are required by default
    param :start_date, 'Format: YYYY-MM-DD', required: false
    param :end_date, 'Format: YYYY-MM-DD', required: false

    # Filters only apply to GET, HEAD and OPTIONS requests
    # Like allowed params, :id is registered by default. Requests without an ID
    # should return an array of 1 or more resources (that match any filters
    # applied). Unlike allowed params, filters are not required by default.
    filter :start_date, 'Format: YYYY-MM-DD'
    filter :end_date, 'Format: YYYY-MM-DD'
    filter :parent_id, 'Parent ID of Thing', required: true


    # Handle API Requests
    #
    # - Simply return a string to be used as the body of the response. How you generate
    #   that string is completely up to you.
    # - Status Codes and Headers will be handled automatically.
    # - Any unhandled requests will return a 405 "Method Not Supported" error

    request(:get) do
      # retrieve 1-N objects...
      '{ ... }'
    end

    # Options and Head requests will be handled automatically and
    # will use info from the GET request block you define, as needed.

    # POST Requests should return the full object that was created during the request.
    request(:post) do
      # create the object...
      '{ ... }'
    end

    # PUT Requests should return the full object that was updated during the request.
    request(:put) do
      # 'upsert' the object...
      '{ ... }'
    end

    # PATCH requests should return the full object that was updated during the request.
    request(:patch) do
      # update the object...
      '{ ... }'
    end

    # DELETE requests should return a simple response indicating success.
    request(:delete) do
      # delete the object...
      '{"deleted":true}'
    end
  end
end

# config.ru
run Hyperdrive::Server
```

## CLI

### Generating Documentation

`$ hyperdrive docs <option> <parameter>`

__`--input` Option__

Use the `--input` option and specify a file or directory as a parameter to generate documentation for your API resources.

  - `$ hyperdrive docs --input api.rb`

or

  - `$ hyperdrive docs --input api`

`-in` can be used as an alias for `--input`

__`--output` Option__

You can also provide a `--output` option and specify a destination for your documentation to be created.

  - `$ hyperdrive docs --input api.rb --output docs/docs.md`

`-out` can be used as an alias for `--output`

If the `--output` option is not provided the generated documentation will be written to `docs/doc.md` by default. 

## Project Status


## Contributing

1. Fork it ( http://github.com/styleseek/hyperdrive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
