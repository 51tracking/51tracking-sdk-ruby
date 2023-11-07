$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require '51tracking'

Tracking51.api_key = 'you api key'

begin
  params  = {"tracking_number" => "92612913029511573130094547","courier_code"=>"usps"}
  response = Tracking51::Tracking.create_tracking(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end

begin
  # params  = {"tracking_numbers" => "92612903029511573130094547","courier_code"=>"usps"}
  # params  = {"tracking_numbers" => "92612903029511573130094547,92612903029511573030094548","courier_code"=>"usps"}
  params  = {"created_date_min" => "2023-10-09T06:00:00+00:00","created_date_max"=>"2023-10-10T13:45:00+00:00"}
  response = Tracking51::Tracking.get_tracking_results(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end

begin
  params  = [{"tracking_number" => "92612903029611573130094547","courier_code"=>"usps"},{"tracking_number" => "92612903029711573130094547","courier_code"=>"usps"}]
  response = Tracking51::Tracking.batch_create_trackings(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end

begin
  params  = {"customer_name" => "New name","note"=>"New tests order note"}
  id_string = '9a3aec583781c7096cf744d68287d3d1'
  response = Tracking51::Tracking.update_tracking_by_id(id_string, params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end

begin
  id_string = '9a3aec583781c7096cf744d68287d3d1'
  response = Tracking51::Tracking.delete_tracking_by_id(id_string)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end

begin
  id_string = '9a3aec583781c7096cf744d68287d3d1'
  response = Tracking51::Tracking.retrack_tracking_by_id(id_string)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
  puts "Caught Standard Error: #{e.message}"
end
