# encoding: utf-8

# prepare for hyperspace!

## stdlib
require 'rack'
require 'rack/accept'
require 'linguistics'; Linguistics.use(:en)
require 'oj'

## immutable values
require 'hyperdrive/values'
require 'hyperdrive/version'

## sugar and state
require 'hyperdrive/dsl'
require 'hyperdrive/errors'
require 'hyperdrive/resource'
require 'hyperdrive/param'
require 'hyperdrive/filter' # must come after param

## rack apps and middleware
require 'hyperdrive/hateoas'
require 'hyperdrive/middleware'

## tools
require 'hyperdrive/docs'
require 'hyperdrive/utils'

require 'hyperdrive/response'
require 'hyperdrive/request_handler'
require 'hyperdrive/server'
