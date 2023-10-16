$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rspec'
require '51tracking'

describe Tracking51::Tracking do
  before do
    Tracking51.api_key = 'you api key'
  end

  describe '.create_tracking' do
    context 'with valid parameters' do
      it 'creates a tracking' do
        params = { "tracking_number" => "92611903029511573030094547", "courier_code" => "usps" } # Uncreated Order Numbers
        response = Tracking51::Tracking.create_tracking(params)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end

    context 'with missing tracking_number' do
      it 'raises an exception' do
        params = { "tracking_number" => "", "courier_code" => "usps" }
        expect { Tracking51::Tracking.create_tracking(params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrMissingTrackingNumber)
      end
    end

    context 'with missing courier_code' do
      it 'raises an exception' do
        params = { "tracking_number" => "92612903029511573030094547", "courier_code" => "" }
        expect { Tracking51::Tracking.create_tracking(params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrMissingCourierCode)
      end
    end
  end

  describe '.get_tracking_results' do
    context 'get_tracking_results' do
      it 'returns tracking results' do
        params  = {"tracking_numbers" => "92612903029511573130094547,92612903029511573030094548","courier_code"=>"usps"}
        response = Tracking51::Tracking.get_tracking_results(params)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end
  end

  describe '.batch_create_trackings' do
    context 'with valid params' do
      it 'creates trackings successfully' do
        params = [
          { "tracking_number" => "92612903029611573130094547", "courier_code" => "usps" },
          { "tracking_number" => "92612903029611573130094548", "courier_code" => "usps" }
        ]
        response = Tracking51::Tracking.batch_create_trackings(params)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end

    context 'with too many tracking numbers' do
      it 'raises an exception' do
        params = []
        41.times { |i| params << { "tracking_number" => "T#{i}", "courier_code" => "Courier#{i}" } }
        expect { Tracking51::Tracking.batch_create_trackings(params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrMaxTrackingNumbersExceeded)
      end
    end

    context 'with missing tracking number' do
      it 'raises an exception' do
        params = [{ "tracking_number" => "", "courier_code" => "UPS" }]
        expect { Tracking51::Tracking.batch_create_trackings(params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrMissingTrackingNumber)
      end
    end

    context 'with missing courier code' do
      it 'raises an exception' do
        params = [{ "tracking_number" => "12345", "courier_code" => "" }]
        expect { Tracking51::Tracking.batch_create_trackings(params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrMissingCourierCode)
      end
    end
  end

  describe '.update_tracking_by_id' do
    context 'with a valid id' do
      it 'updates tracking information successfully' do
        id_string = '99f4ed7fc73aa83fe68fd69ab6458b28'
        params = {"customer_name" => "New name","note"=>"New tests order note"}
        response = Tracking51::Tracking.update_tracking_by_id(id_string, params)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end

    context 'with an empty id' do
      it 'raises an exception' do
        id_string = ''
        params = {"customer_name" => "New name","note"=>"New tests order note"}
        expect { Tracking51::Tracking.update_tracking_by_id(id_string, params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrEmptyId)
      end
    end
  end

  describe '.delete_tracking_by_id' do
    context 'with a valid id' do
      it 'deletes tracking information successfully' do
        id_string = '9a3b187d8fb6b600809859e778b632c3'
        response = Tracking51::Tracking.delete_tracking_by_id(id_string)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end

    context 'with an empty id' do
      it 'raises an exception' do
        id_string = ''
        expect { Tracking51::Tracking.delete_tracking_by_id(id_string) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrEmptyId)
      end
    end
  end

  describe '.retrack_tracking_by_id' do
    context 'with a valid id' do
      it 'retracks tracking information successfully' do
        id_string = '9a3b187d8fb6b600809859e778b632c3' # Replace with expired tracking order number
        response = Tracking51::Tracking.retrack_tracking_by_id(id_string)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end

    context 'with an empty id' do
      it 'raises an exception' do
        id_string = ''
        expect { Tracking51::Tracking.retrack_tracking_by_id(id_string) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrEmptyId)
      end
    end
  end
end
