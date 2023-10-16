require File.dirname(__FILE__) + '/request'

module Tracking51
  class Tracking
    @@api_module = 'trackings'

    def self.create_tracking(params = {})
      if params["tracking_number"].to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMissingTrackingNumber)
      end
      if params["courier_code"].to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMissingCourierCode)
      end
      Tracking51::Request.make_request('post',"#@@api_module/create",params)
    end

    def self.get_tracking_results(params = {})
      Tracking51::Request.make_request('get',"#@@api_module/get",params)
    end

    def self.batch_create_trackings(params = [])
      if params.length > 40
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMaxTrackingNumbersExceeded)
      end
      params.each do |item|
        if item["tracking_number"].to_s.empty?
          raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMissingTrackingNumber)
        end
        if item["courier_code"].to_s.empty?
          raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrMissingCourierCode)
        end
      end
      Tracking51::Request.make_request('post',"#@@api_module/batch",params)
    end

    def self.update_tracking_by_id(id_string, params = {})
      if id_string.to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrEmptyId)
      end
      Tracking51::Request.make_request('put',"#@@api_module/update/"+id_string,params)
    end

    def self.delete_tracking_by_id(id_string)
      if id_string.to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrEmptyId)
      end
      Tracking51::Request.make_request('delete',"#@@api_module/delete/"+id_string)
    end

    def self.retrack_tracking_by_id(id_string)
      if id_string.to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrEmptyId)
      end
      Tracking51::Request.make_request('post',"#@@api_module/retrack/"+id_string)
    end
  end
end
