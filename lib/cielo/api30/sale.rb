module Cielo
  module API30
    class Sale < OptionTemplate
      attr_accessor :merchant_order_id,
                    :customer,
                    :payment,
                    :fraud_analysis

      def initialize(merchant_order_id)
        @merchant_order_id = merchant_order_id
      end

      def self.from_json(data)
        return if data.nil?

        sale = new(data["MerchantOrderId"])
        sale.customer = Customer.from_json(data["Customer"])
        sale.payment = Payment.from_json(data["Payment"])
        sale
      end

      def as_json(options={})
        {
          MerchantOrderId: merchant_order_id,
          Customer: customer,
          Payment: payment,
          # FraudAnalysis: fraud_analysis
          "FraudAnalysis":{
            "Sequence":"AuthorizeFirst",
            "SequenceCriteria":"OnSuccess",
            "Provider":"CyberSource",
            "FingerPrintId":"074c1ee676ed4998ab66491013c565e2",
            "CaptureOnLowRisk":true,
            "VoidOnHighRisk":false,
            "Browser":{
              "CookiesAccepted":false,
              "Email":"compradorteste@live.com",
              "HostName":"Teste",
              "IpAddress":"200.190.150.350",
              "Type":"Chrome"
            },
            "Cart":{
              "IsGift":false,
              "ReturnsAccepted":true,
              "Items":[
              {
                  "GiftCategory":"Undefined",
                  "HostHedge":"Off",
                  "NonSensicalHedge":"Off",
                  "ObscenitiesHedge":"Off",
                  "PhoneHedge":"Off",
                  "Name":"ItemTeste",
                  "Quantity":1,
                  "Sku":"201411170235134521346",
                  "UnitPrice":123,
                  "Risk":"High",
                  "TimeHedge":"Normal",
                  "Type":"AdultContent",
                  "VelocityHedge":"High",
                  "Passenger":{
                    "Email":"compradorteste@live.com",
                    "Identity":"1234567890",
                    "Name":"Comprador accept",
                    "Rating":"Adult",
                    "Phone":"999994444",
                    "Status":"Accepted"
                  }
              }
              ]
            },
            "MerchantDefinedFields":[
              {
                "Id":95,
                "Value":"Eu defini isso"
              }
            ],
            "Shipping":{
              "Addressee":"Sr Comprador Teste",
              "Method":"LowCost",
              "Phone":"21114740"
            },
            "Travel":{
              "DepartureTime":"2010-01-02",
              "JourneyType":"Ida",
              "Route":"MAO-RJO",
              "Legs":[
                {
                  "Destination":"GYN",
                  "Origin":"VCP"
                }
              ]
            }
          }
        }
      end
    end
  end
end
