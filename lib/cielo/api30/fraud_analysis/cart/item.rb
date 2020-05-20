module Cielo
  module API30
    module FraudAnalysis
      module Cart
        class Item < OptionTemplate
          def initialize(name:, quantity:, sku:, unit_price:)
            @name = name
            @quantity = quantity
            @sku = sku
            @unit_price = unit_price
          end

          def as_json(options={})
            {
              GiftCategory: gift_category,
              HostHedge: host_hedge,
              NonSensicalHedge: non_sensical_hedge,
              ObscenitiesHedge: obscenities_hedge,
              PhoneHedge: phone_hedge,
              Name: name,
              Quantity: quantity,
              Sku: sku,
              UnitPrice: unit_price,
              Risk: risk,
              VelocityHedge: velocity_hedge,
            }
          end
        end
      end
    end
  end
end
