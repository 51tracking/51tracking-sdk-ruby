require File.dirname(__FILE__) + '/request'

module Tracking51
  class Courier
    @@api_module = 'couriers'
    def self.get_all_couriers
      Tracking51::Request.make_request('get',"#@@api_module/all")
    end
    def self.detect(params = {})
      if params["tracking_number"].to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMissingTrackingNumber)
      end
      Tracking51::Request.make_request('post',"#@@api_module/detect",params)
    end
  end
end