# encoding: utf-8

# stdlib
require 'rack'
require 'rack/accept'
require 'linguistics'; Linguistics.use(:en)
require 'oj'
require 'ox'

# prepare for hyperspace!
require 'hyperdrive/values'
require 'hyperdrive/docs'
require 'hyperdrive/dsl'
require 'hyperdrive/errors'
require 'hyperdrive/middleware'
require 'hyperdrive/param'
require 'hyperdrive/filter' # must come after param
require 'hyperdrive/utils'
require 'hyperdrive/version'

require 'hyperdrive/resource'
require 'hyperdrive/response'
require 'hyperdrive/request_handler'
require 'hyperdrive/server'
