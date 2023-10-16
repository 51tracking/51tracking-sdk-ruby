require File.dirname(__FILE__) + '/request'

module Tracking51
  class AirWaybill
    def self.create_an_air_waybill(params = {})
      if params["awb_number"].to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMissingAwbNumber)
      end
      if params["awb_number"].length != 12
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrInvalidAirWaybillFormat)
      end
      Tracking51::Request.make_request('post',"awb",params)
    end
  end
end