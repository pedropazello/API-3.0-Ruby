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
                    :browser

      def initialize(provider: "cybersource", sequence: "AnalyseFirst",
        sequence_criteria: "Always", total_order_amount:, finger_print_id:)
        @provider = provider
        @sequence = sequence
        @sequence_criteria = sequence_criteria
        @total_order_amount = total_order_amount
        @finger_print_id = finger_print_id
      end

      def as_json(options={})
        {
          Sequence: sequence,
          SequenceCriteria: sequence_criteria,
          CaptureOnLowRisk: capture_on_low_risk,
          VoidOnHighRisk: void_on_high_risk,
          TotalOrderAmount: total_order_amount,
          FingerPrintId: finger_print_id,
          Browser: browser&.as_json || {},
        }
      end
    end
  end
end
