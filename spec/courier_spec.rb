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
end