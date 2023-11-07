$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require '51tracking'

Tracking51.api_key = 'you api key'

begin
  response = Tracking51::Courier.get_all_couriers
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end

