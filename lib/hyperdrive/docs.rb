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
        out += paragraph(bullet(code(resource.endpoint), 1))
        out += header("Params", 2)
        out += list(resource.params.map { |_,param| param.to_hash })
        out += header("Filters", 2)
        out += list(resource.filters.map { |_,filter| filter.to_hash })
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
      "#{nest}- #{string}\n"
    end

    def list(items)
      list = ""
      items.each do |item|
        list += bullet(bold(item[:name]), 1)
        item.each do |key, value|
          list += bullet(italics(key), 2)

          if value.kind_of? Array
            list += bullet(code_options(value), 3)
          else
            list += bullet(value, 3)
          end
        end
      end
      list
    end

    def code_options(options)
      options.map { |option| code(option) }.join(", ")
    end
  end
end
