# encoding: utf-8

module Hyperdrive
  class Docs
    attr_reader :resources
    
    def initialize(resources)
      @resources = resources
      @docs = ""
    end

    def header(string, level = 1)
      raise ArgumentError, "Header level must be between 1 and 6." unless (1..6).cover?(level)
      header = "#" * level
      "\n#{header} #{string}\n\n"
    end

    def paragraph(string)
      "#{string}\n"
    end

    def bold(string)
      "__#{string}__"
    end

    def code(string)
      "`#{string}`"
    end

    def bullet(string, nest = 0)
      nest = " " * nest
      "#{nest}- #{string}"
    end

    def endpoints(endpoint)
      paragraph(bullet(code(endpoint), 2))
    end

    def params(params)
      params_list = ""
      params.each do |k, v|
        params_list += param_name(k)
        params_list += param_desc(v[:desc])
        params_list += required(v[:required])
      end
      params_list
    end

    def param_name(name)
      "#{bullet(bold(name), 2)} - "
    end

    def param_desc(desc)
      paragraph(desc)
    end

    def required(required_opts)
      default_opts = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]

      if array?(required_opts)
        generate_requirements_docs(required_opts)
      elsif required_opts == true
        generate_requirements_docs(default_opts)
      else
        string = ""
      end
    end

    def array?(required_opt)
      required_opt.kind_of? Array
    end

    def generate_requirements_docs(opts)
      string = "\n#{bullet(bold('Required'), 4)}: "
      opts.each { |opt| string += "#{code(opt)} "}
      "#{string}\n\n"
    end

    def output
      @docs += "# HYPERDRIVE API\n"
      resources.each_value do |resource|
        @docs += header(resource.name)
        @docs += paragraph(resource.desc)
        @docs += header("Endpoint URLS", 2)
        @docs += "  - `#{resource.endpoint}`\n"
        @docs += header("Params", 2)
        @docs += params(resource.allowed_params)
        @docs += header("Filter", 2)
        @docs += params(resource.filters)
      end
      @docs
    end



  end 
end
