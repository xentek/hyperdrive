# encoding: utf-8

# stdlib
require 'rack'
require 'rack/accept'
require 'linguistics'
Linguistics.use(:en)

# prepare for hyperspace!
require 'hyperdrive/docs'
require 'hyperdrive/dsl'
require 'hyperdrive/errors'
require 'hyperdrive/middleware'
require 'hyperdrive/utils'

require 'hyperdrive/resource'
require 'hyperdrive/response'
require 'hyperdrive/request_handler'
require 'hyperdrive/server'
require 'hyperdrive/values'
require 'hyperdrive/version'
