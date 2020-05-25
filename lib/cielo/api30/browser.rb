module Cielo
  module API30
    class Browser < OptionTemplate
      attr_accessor :cookies_accepted,
                    :email,
                    :host_name,
                    :ip_address,
                    :type,

       def as_json(options={})
        {
          CookiesAccepted: cookies_accepted,
          Email: email,
          HostName: host_name,
          IpAddress: ip_address,
          Type: type,
        }
      end
    end
  end
end
