module Hyperdrive
  module Verbs
    def self.default 
      %w(GET HEAD OPTIONS POST PUT PATCH DELETE).freeze
    end
  end
end