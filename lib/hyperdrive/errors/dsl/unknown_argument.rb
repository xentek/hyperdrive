module Hyperdrive
  module Errors
    module DSL
      class UnknownArgument < RuntimeError
        def initialize(argument, method_name)
          @argument = case argument
                      when Symbol
                        ":#{argument}"
                      else
                        argument.to_s
                      end
          @method_name = method_name
        end

        def message
          "DSL Error: The argument you supplied (#{@argument}) is not supported by the `#{@method_name}' method."
        end
      end
    end
  end
end
