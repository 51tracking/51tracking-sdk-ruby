require File.dirname(__FILE__) + '/request'

module Tracking51
  class Courier
    @@api_module = 'couriers'
    def self.get_all_couriers
      Tracking51::Request.make_request('get',"#@@api_module/all")
    end
  end
end