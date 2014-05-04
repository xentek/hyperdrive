# encoding: utf-8

module Hyperdrive
  class Param
    attr_reader :name, :description, :required, :type, :constraints

    def initialize(name, description, options = {})
      @name = name.to_s
      @description = description
      options = default_options.merge(options)
      @required = if options[:required] == true
                    %w(POST PUT PATCH)
                  elsif options[:required] == false
                    []
                  else
                    Array(options[:required])
                  end
      @type = options[:type]
      @constraints = "#{required_constraint} #{options[:constraints]}"
    end

    def required?(http_request_method)
      @required.include? http_request_method
    end

    def to_hash
      { name: @name, description: @description, type: @type, constraints: @constraints }
    end

    private

    def default_options
      { required: true, type: 'String', constraints: nil }
    end

    def required_constraint
      if @required.empty?
        ''
      else
        "Required for: #{@required.join(', ')}."
      end
    end
  end
end
