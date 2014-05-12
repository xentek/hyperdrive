# encoding: utf-8

# DSL Errors
require 'hyperdrive/errors/dsl/unknown_argument'

# HTTP Errors
require 'hyperdrive/errors/http_error'
require 'hyperdrive/errors/bad_request' # 400 (Generic)
require 'hyperdrive/errors/internal_server_error' # 500 (Generic)
require 'hyperdrive/errors/json_parse_error' # 400 (Specific)
require 'hyperdrive/errors/method_not_allowed' # 405
require 'hyperdrive/errors/missing_required_param' # 400 (Specific)
require 'hyperdrive/errors/no_response' # 444
require 'hyperdrive/errors/not_acceptable' # 406
require 'hyperdrive/errors/not_found' # 404
require 'hyperdrive/errors/not_implemented' # 501
require 'hyperdrive/errors/unauthorized' # 401
require 'hyperdrive/errors/unknown_error' # 500 (Catch All)
