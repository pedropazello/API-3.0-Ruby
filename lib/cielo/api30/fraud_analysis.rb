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
                    :json_response

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

        json
      end
    end
  end
end
