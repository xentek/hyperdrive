# encoding: utf-8

# prepare for hyperspace!

## stdlib
require 'rack'
require 'rack/accept'
require 'linguistics'; Linguistics.use(:en)
require 'multi_json'

## immutable values
require 'hyperdrive/values'
require 'hyperdrive/version'

## helpers
require 'hyperdrive/docs'
require 'hyperdrive/utils'

## sugary syntax and state mangagement
require 'hyperdrive/dsl'
require 'hyperdrive/errors'
require 'hyperdrive/param'
require 'hyperdrive/filter' # must come after param
require 'hyperdrive/resource'

## rack apps and middleware
require 'hyperdrive/endpoint'
require 'hyperdrive/hateoas'
require 'hyperdrive/middleware'
require 'hyperdrive/server'
