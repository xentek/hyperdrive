# encoding: utf-8

module Hyperdrive
  class Filter < Param
    def initialize(name, description, options = {})
      @name = name.to_s
      @description = description
      options = default_options.merge(options)
      @required = if options[:required] == true
                    %w(GET HEAD)
                  elsif options[:required] == false
                    []
                  else
                    Array(options[:required])
                  end
      @type = options[:type]
      @constraints = "#{required_constraint} #{options[:constraints]}"
    end
  end
end
