$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rspec'
require '51tracking'

describe Tracking51::Courier do
  before do
    Tracking51.api_key = 'you api key'
  end

  describe '.get_all_couriers' do
    context 'get_all_couriers' do
      it 'returns a list of couriers' do
        response = Tracking51::Courier.get_all_couriers
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end
    end
  end

  describe '.detect' do
    context 'detect' do
      it 'detects a tracking number' do
        params = { "tracking_number" => "YOUR_TRACKING_NUMBER" }
        response = Tracking51::Courier.detect(params)
        expect(response).to be_a(Hash)
        expect(response['meta']['code']).to eq(200)
      end

      it 'raises an exception for missing tracking number' do
        params = { "tracking_number" => "" }
        expect { Tracking51::Courier.detect(params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrMissingTrackingNumber)
      end
    end
  end
end