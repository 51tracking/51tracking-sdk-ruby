51tracking-sdk-ruby
=================
 
The Ruby SDK of 51Tracking API

Contact: <service@51tracking.org>

## Official document

[Document](https://www.51tracking.com/v4/api-index/API-)


## Index
1. [Installation](https://github.com/51tracking/51tracking-sdk-ruby#installation)
2. [Testing](https://github.com/51tracking/51tracking-sdk-ruby#testing)
3. [Error Handling](https://github.com/51tracking/51tracking-sdk-ruby#error-handling)
4. SDK
    1. [Couriers](https://github.com/51tracking/51tracking-sdk-ruby#couriers)
    2. [Trackings](https://github.com/51tracking/51tracking-sdk-ruby#trackings)
    3. [Air Waybill](https://github.com/51tracking/51tracking-sdk-ruby#air-waybill)


## Installation

```
gem install 51tracking
```

## Quick Start

```ruby
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

```

## Testing
```
rspec
```

## Error handling

**Throw** by the new SDK client

```ruby
require '51tracking'

Tracking51.api_key = ''

begin
   response = Tracking51::Courier.get_all_couriers
   puts response
rescue Tracking51::Tracking51Exception => e
   puts "Caught Custom Exception: #{e.message}"
end

# API Key is missing
```

**Throw** by the parameter validation in function

```ruby
require '51tracking'

Tracking51.api_key = 'you api key'

begin
   params  = {"tracking_number" => "","courier_code"=>"usps"}
   response = Tracking51::Tracking.create_tracking(params)
   puts response
rescue Tracking51::Tracking51Exception => e
   puts "Caught Custom Exception: #{e.message}"
end

# Tracking number cannot be empty
```
## Examples

## Couriers
##### 返回所有支持的快递公司列表
https://api.51Tracking.com/v4/couriers/all
```ruby
begin
  response = Tracking51::Courier.get_all_couriers
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```

## Trackings
##### 单个物流单号实时添加且查询
https://api.51Tracking.com/v4/trackings/create
```ruby
begin
  params  = {"tracking_number" => "92612913029511573130094547","courier_code"=>"usps"}
  response = Tracking51::Tracking.create_tracking(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```

##### 获取多个物流单号的查询结果
https://api.51Tracking.com/v4/trackings/get
```ruby
begin
  # Perform queries based on various conditions
  # params  = {"tracking_numbers" => "92612903029511573130094547","courier_code"=>"usps"}
  # params  = {"tracking_numbers" => "92612903029511573130094547,92612903029511573030094548","courier_code"=>"usps"}
  params  = {"created_date_min" => "2023-08-23T14:00:00+00:00","created_date_max"=>"2023-08-23T15:04:00+00:00"}
  response = Tracking51::Tracking.get_tracking_results(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```

##### 添加多个物流单号（一次调用最多创建 40 个物流单号）
https://api.51Tracking.com/v4/trackings/batch
```ruby
begin
  params  = [{"tracking_number" => "92612903029611573130094547","courier_code"=>"usps"},{"tracking_number" => "92612903029711573130094547","courier_code"=>"usps"}]
  response = Tracking51::Tracking.batch_create_trackings(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```

##### 根据ID更新物流信息
https://api.51Tracking.com/v4/trackings/update/{id}
```ruby
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
```

##### 通过ID删除单号
https://api.51Tracking.com/v4/trackings/delete/{id}
```ruby
begin
  id_string = '9a3aec583781c7096cf744d68287d3d1'
  response = Tracking51::Tracking.delete_tracking_by_id(id_string)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```

##### 通过ID重新查询过期的单号
https://api.51Tracking.com/v4/trackings/retrack/{id}
```ruby
begin
  id_string = '9a3aec583781c7096cf744d68287d3d1'
  response = Tracking51::Tracking.retrack_tracking_by_id(id_string)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```
## Air Waybill
##### 查询航空运单的结果
https://api.51Tracking.com/v4/awb
```ruby
begin
  params  = {"awb_number" => "235-69030430"}
  response = Tracking51::AirWaybill.create_an_air_waybill(params)
  puts response
rescue Tracking51::Tracking51Exception => e
  puts "Caught Custom Exception: #{e.message}"
rescue StandardError => e
   puts "Caught Standard Error: #{e.message}"
end
```

## 响应状态码

51Tracking 使用传统的HTTP状态码来表明 API 请求的状态。通常，2xx形式的状态码表示请求成功，4XX形式的状态码表请求发生错误（比如：必要参数缺失），5xx格式的状态码表示 51tracking 的服务器可能发生了问题。

| Http CODE | META CODE | TYPE               | MESSAGE                                   |
|-----------|-----------|--------------------|-------------------------------------------|
| 200       | 200       | <code>成功</code>    | 请求响应成功。                                   |
| 400       | 400       | <code>错误请求</code>  | 请求类型错误。请查看 API 文档以了解此 API 的请求类型。          |
| 400       | 4101      | <code>错误请求</code>  | 物流单号已存在。                                  |
| 400       | 4102      | <code>错误请求</code>  | 物流单号不存在。请先使用「Create接口」将单号添加至系统。           |
| 400       | 4103      | <code>错误请求</code>  | 您已超出 API 调用的创建数量。每次创建的最大数量为 40 个快递单号。     |
| 400       | 4110      | <code>错误请求</code>  | 物流单号(tracking_number) 不符合规则。              |
| 400       | 4111      | <code>错误请求</code>  | 物流单号(tracking_number)为必填字段。               |
| 400       | 4112      | <code>错误请求</code>  | 查询ID无效。                                   |
| 400       | 4113      | <code>错误请求</code>  | 不允许重新查询。您只能重新查询过期的物流单号。                   |
| 400       | 4120      | <code>错误请求</code>  | 物流商简码(courier_code)的值无效。                  |
| 400       | 4121      | <code>错误请求</code>  | 无法识别物流商。                                  |
| 400       | 4122      | <code>错误请求</code>  | 特殊物流商字段缺失或填写不符合规范。                        |
| 400       | 4130      | <code>错误请求</code>  | 请求参数的格式无效。                                |
| 400       | 4160      | <code>错误请求</code>  | 空运单号(awb_number)是必需的或有效的格式。               |
| 400       | 4161      | <code>错误请求</code>  | 此空运航空不支持查询。                               |
| 400       | 4165      | <code>错误请求</code>  | 查询失败：未创建空运单号。                             |
| 400       | 4166      | <code>错误请求</code>  | 删除未创建的空运单号失败。                             |
| 400       | 4167      | <code>错误请求</code>  | 空运单号已存在，无需再次创建。                           |
| 400       | 4190      | <code>错误请求</code>  | 当前查询额度不足。                                 |
| 401       | 401       | <code>未经授权</code>  | 身份验证失败或没有权限。请检查并确保您的 API 密钥正确无误。          |
| 403       | 403       | <code>禁止</code>    | 禁止访问。请求被拒绝或不允许访问。                         |
| 404       | 404       | <code>未找到</code>   | 页面不存在。请检查并确保您的链接正确无误。                     |
| 429       | 429       | <code>太多请求</code>  | 超出 API 请求限制，请稍后重试。请查看 API 文档以了解此 API 的限制。 |
| 500       | 511       | <code>服务器错误</code> | 服务器错误。请联系我们： service@51Tracking.org。      |
| 500       | 512       | <code>服务器错误</code> | 服务器错误。请联系我们：service@51Tracking.org。       |
| 500       | 513       | <code>服务器错误</code> | 服务器错误。请联系我们： service@51Tracking.org。      |