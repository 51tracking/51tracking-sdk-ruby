$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rspec'
require '51tracking'

describe Tracking51::Request do
  before do
    Tracking51.api_key = 'you api key'
  end

  describe '.make_request' do
    context 'make_request' do
      it 'with valid apikey' do
        params = { "awb_number" => "235-69030430" }
        Tracking51::Request.make_request('post',"awb",params)
      end
      it 'raises an exception for missing apikey' do
        Tracking51.api_key = ''
        params = { "awb_number" => "235-69030430" }
        expect { Tracking51::Request.make_request('post',"awb",params) }.to raise_error(Tracking51::Tracking51Exception, Tracking51::Consts::ErrEmptyAPIKey)
      end
    end
  end

end