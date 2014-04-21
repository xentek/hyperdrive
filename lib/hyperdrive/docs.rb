# encoding: utf-8

module Hyperdrive
  class Docs
    attr_reader :resources

    def initialize(resources)
      @resources = resources
    end

    def output
      out = ""
      resources.each_value do |resource|
        out += header(resource.name)
        out += paragraph(resource.desc)
        out += header("Endpoint URL", 2)
        out += paragraph(bullet(code(resource.endpoint), 2))
        out += header("Params", 2)
        out += list(resource.allowed_params)
        out += header("Filter", 2)
        out += list(resource.filters)
      end
      out
    end

    def header(string, level = 1)
      raise ArgumentError, "Header level must be between 1 and 6." unless (1..6).cover?(level)
      header = "#" * level
      "\n\n#{header} #{string}\n\n"
    end

    def paragraph(string)
      "#{string}\n\n"
    end

    def bold(string)
      "__#{string}__"
    end

    def italics(string)
      "_#{string}_"
    end

    def code(string)
      "`#{string}`"
    end

    def bullet(string, nest = 1)
      raise ArgumentError, "Nest level must be between 1 and 3." unless (1..3).cover?(nest)
      nest = "  " * nest
      "\n#{nest}- #{string}\n"
    end

    def list(params)
      list = ""
      params.each do |key, value|
        list += "#{bullet(bold(key), 1)}: "
        list += paragraph(value[:desc])
        list += "#{bullet(bold('Required'), 2)}: "
        list += if value[:required].kind_of? Array
                  code_options(value[:required])
                elsif value[:required] == true
                  code_options(Hyperdrive::Verbs.default)
                else
                  italics('none')
                end
      end
      list
    end

    def code_options(options)
      options.map { |option| code(option) }.join(", ")
    end
  end
end