=begin
require 'socket'
  ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  my_ip = ip.ip_address if ip

  if my_ip == "192.41.170.117"
    module Faraday
      class Connection
        alias_method :old_initialize, :initialize

        def initialize(url = nil, options = {})
          proxy = 'https://192.41.170.23:3128'
          (url.is_a?(Hash) ? url : options).merge!(proxy: proxy)
          old_initialize(url, options)
        end
      end
    end
  end
=end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '977169502299183', 'aa9952595c4dd420ececf49e8702222a'
end
