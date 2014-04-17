# Hyperdrive

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
  end
end

# config.ru
run Hyperdrive::Server
```



## Project Status

- Version: [![Gem Version](https://badge.fury.io/rb/hyperdrive.png)](http://badge.fury.io/rb/hyperdrive)
- Build: [![Build Status](https://secure.travis-ci.org/styleseek/hyperdrive.png?branch=master)](https://travis-ci.org/styleseek/hyperdrive)
- Code Quality: [![Code Climate](https://codeclimate.com/github/styleseek/hyperdrive.png)](https://codeclimate.com/github/styleseek/hyperdrive)
- Test Coverage: [![Coverage Status](https://coveralls.io/repos/styleseek/hyperdrive/badge.png)](https://coveralls.io/r/styleseek/hyperdrive)
- Dependencies: [![Dependency Status](https://gemnasium.com/styleseek/hyperdrive.png)](https://gemnasium.com/styleseek/hyperdrive)

## Contributing

1. Fork it ( http://github.com/styleseek/hyperdrive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
