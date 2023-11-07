$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require '51tracking'

Tracking51.api_key = 'you api key'

begin
  params  = {"awb_number" => "235-69030430"}
  response = Tracking51::AirWaybill.create_an_air_waybill(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end
