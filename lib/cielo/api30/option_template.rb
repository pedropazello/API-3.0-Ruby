module Cielo
  module API30
    class OptionTemplate
      def to_json(*options)
        hash = as_json(*options)
        hash.reject! {|k,v| v.nil?}
        hash.to_json(*options)
      end

      def self.from_json(data)
        raise NotImplementedError, "subclass did not define .from_json"
      end

      def as_json(options={})
        raise NotImplementedError, "subclass did not define #as_json"
      end
    end
  end
end
