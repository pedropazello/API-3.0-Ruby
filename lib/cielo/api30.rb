require "cielo/environment"
require "cielo/merchant"

require "cielo/api30/address"
require "cielo/api30/credit_card"
require "cielo/api30/customer"
require "cielo/api30/payment"
require "cielo/api30/recurrent_payment"
require "cielo/api30/sale"

require "cielo/api30/request/create_sale_request"
require "cielo/api30/request/query_sale_request"
require "cielo/api30/request/update_sale_request"

module Cielo
    #  The Cielo API SDK front-end
    class API30
        attr_accessor :merchant, :environment
        private :merchant, :environment

        # Create an instance of API by choosing the environment where the
        # requests will be send
        #
        # @param merchant [Merchant] The merchant credentials
        # @param environment [Environment] The environment
        def initialize(
            merchant,
            environment = nil)

            if (environment == nil)
                environment = Environment.production()
            end

            @merchant = merchant
            @environment = environment
        end

        # Send the Sale to be created and return the Sale with tid and the status
        # returned by Cielo.
        #
        # @param sale [Sale] The preconfigured Sale
        # @return [Sale] The Sale with authorization, tid, etc. returned by Cielo.
        def create_sale(sale)
            request = Cielo::Request::CreateSaleRequest.new(merchant, environment)

            request.execute(sale)
        end

        # Query a Sale on Cielo by paymentId
        #
        # @param payment_id [String] The payment_id to be queried
        # @return [Sale] The Sale with authorization, tid, etc. returned by Cielo.
        def get_sale(payment_id)
            request = Cielo::Request::QuerySaleRequest.new(merchant, environment)

            request.execute(payment_id)
        end

        # Cancel a Payment on Cielo by paymentId and speficying the amount
        #
        # @param payment_id [String] The payment_id to be queried
        # @param amount [Integer] Order value in cents
        # @return [Payment] The cancelled payment
        def cancel_payment(payment_id, amount=nil)
            request = Cielo::Request::UpdateSaleRequest.new("void", merchant, environment)

            request.amount = amount

            request.execute(payment_id)
        end

        # Capture a Sale on Cielo by paymentId and specifying the amount and the
        # serviceTaxAmount
        #
        # @param payment_id [String] The payment_id to be captured
        # @param amount [Integer] Amount of the authorization to be captured
        # @param service_tax_amount [Integer] Amount of the authorization should be destined for the service charge
        # @return [Payment] The captured payment
        def capture_sale(payment_id, amount=nil, service_tax_amount=nil)
            request = Cielo::Request::UpdateSaleRequest.new("capture", merchant, environment)

            request.amount = amount
            request.service_tax_amount = service_tax_amount

            request.execute(payment_id)
        end
    end
end