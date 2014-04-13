# Hyperdrive

Ruby DSL for defining self-documenting, HATEOS™ complaint, Hypermedia endpoints.

## Installation

Add this line to your application's Gemfile:

    gem 'hyperdrive'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyperdrive

## Usage

Proposed Syntax (WIP):

    hyperdrive(:deal) do
      name 'Deals'
      desc 'Exclusive offers and coupons'

      param :name, '50 Chars or less', required: true
      param :start_date, 'Format: YYYY-MM-DD'
      param :end_date, 'Format: YYYY-MM-DD'

      filter :start_date
      filter :end_date
      filter :partner_id, required: true
    end

## Project Status

- Build: [![Build Status](https://secure.travis-ci.org/styleseek/hyperdrive.png?branch=master)](https://travis-ci.org/styleseek/hyperdrive)
- Code Quality: [![Code Climate](https://codeclimate.com/github/styleseek/hyperdrive.png)](https://codeclimate.com/github/styleseek/hyperdrive)
- Dependencies: [![Dependency Status](https://gemnasium.com/styleseek/hyperdrive.png)](https://gemnasium.com/styleseek/hyperdrive)

## Contributing

1. Fork it ( http://github.com/styleseek/hyperdrive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
