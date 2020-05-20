module Cielo
  module API30
    module FraudAnalysis
      class Cart < OptionTemplate
        def initialize
        end

        def as_json(options={})
          {
            IsGift: is_gift,
            ReturnsAccepted: returns_accepted,
            Items: items.map(&:as_json)
          }
        end
      end
    end
  end
end
