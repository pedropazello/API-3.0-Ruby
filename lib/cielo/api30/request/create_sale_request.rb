require "cielo/api30/request/cielo_request"

module Cielo
  module API30
    module Request
      class CreateSaleRequest < CieloRequest
        attr_accessor :environment
        private :environment

        def initialize(merchant, environment)
          super(merchant)
          @environment = environment
        end

        def execute(sale)
          uri = URI.parse([@environment.api, "1", "sales"].join("/"))
          response = send_request("POST", uri, sale)

          Cielo::API30::Sale.from_json(response)
        end
      end
    end
  end
end
