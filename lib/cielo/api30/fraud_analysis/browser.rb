module Cielo
  module API30
    module FraudAnalysis
      class Browser < OptionTemplate
        def initialize(ip_address:, cookies_accepted:)
          @ip_address = ip_address
          @cookies_accepted = cookies_accepted
        end

        def as_json(options={})
          {
            CookiesAccepted: cookies_accepted,
            Email: email,
            HostName: host_name,
            IpAddress: ip_address,
            Type: type,


            IsGift: is_gift,
            ReturnsAccepted: returns_accepted,
            GiftCategory: gift_category,
            HostHedge: host_hedge,
          }
        end
      end
    end
  end
end
