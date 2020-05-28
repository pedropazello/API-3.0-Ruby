module Cielo
  module API30
    class FraudAnalysis < OptionTemplate
      attr_accessor :provider,
                    :sequence,
                    :sequence_criteria,
                    :capture_on_low_risk,
                    :void_on_high_risk,
                    :total_order_amount,
                    :finger_print_id,
                    :browser,
                    :reply_data,
                    :status,
                    :status_description,
                    :fraud_analysis_reason_code,
                    :id,
                    :json_response,
                    :cart,
                    :shipping

      def initialize(provider: "Cybersource", sequence: "AnalyseFirst",
        sequence_criteria: "Always")
        @provider = provider
        @sequence = sequence
        @sequence_criteria = sequence_criteria
      end

      def self.from_json(data)
        return if data.nil?
        fraud_analysis = new(provider: data["Provider"], sequence: data["Sequence"], sequence_criteria: data["SequenceCriteria"])
        fraud_analysis.id = data["Id"]
        fraud_analysis.status = data["Status"]
        fraud_analysis.status_description = data["StatusDescription"]
        fraud_analysis.reply_data = data["ReplyData"]
        fraud_analysis.fraud_analysis_reason_code = data["FraudAnalysisReasonCode"]
        fraud_analysis.json_response = data
        fraud_analysis
        fraud_analysis
      end

      def as_json(options={})
        json = {
          Sequence: sequence,
          SequenceCriteria: sequence_criteria,
          Provider: provider,
          FingerPrintId: finger_print_id,
          CaptureOnLowRisk: capture_on_low_risk,
          VoidOnHighRisk: void_on_high_risk,
          TotalOrderAmount: total_order_amount,
        }

        if browser.present?
          json[:Browser] = {
            CookiesAccepted: browser[:cookies_accepted],
            Email: browser[:email],
            HostName: browser[:host_name],
            IpAddress: browser[:ip_address],
            Type: browser[:type],
          }
        end

        if cart.present?
          json[:Cart] = {
            IsGift: cart[:is_gift],
            ReturnsAccepted: cart[:returns_accepted],
            Items: cart[:items].map do |item|
              {
                GiftCategory: item[:gift_category],
                HostHedge: item[:host_hedge],
                NonSensicalHedge: item[:non_sensical_hedge],
                ObscenitiesHedge: item[:obscenities_hedge],
                PhoneHedge: item[:phone_hedge],
                Name: item[:name],
                Quantity: item[:quantity],
                Sku: item[:sku],
                UnitPrice: item[:unit_price],
                Risk: item[:risk],
                TimeHedge: item[:time_hedge],
                Type: item[:type],
                VelocityHedge: item[:velocity_hedge],
              }
            end
          }
        end

        if shipping.present?
          json[:Shipping] = {
            Addressee: shipping[:addressee],
            Method: shipping[:method],
            Phone: shipping[:phone]
          }
        end

        json
      end
    end
  end
end
