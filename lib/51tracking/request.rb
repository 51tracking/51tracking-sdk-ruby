require 'net/http'
require 'uri'
require 'json'

module Tracking51
  class Request
    @@apiBaseUrl = 'api.51Tracking.com'
    @@apiPort = 443
    @@apiVersion = 'v4'
    @@timeout = 10

    def self.get_request_url(path)
      pact = @@apiPort == 443 ? 'https' : 'http'
      url = pact+'://'+@@apiBaseUrl+'/'+@@apiVersion+'/'+path
      return url
    end

    def self.get_request_header(apiKey)
      headers = {}
      headers['Accept'] = 'application/json'
      headers['Content-Type'] = 'application/json'
      headers['Tracking-Api-Key'] = apiKey
      return headers
    end

    def self.make_request(method = 'GET', path = '', params = nil)

      if Tracking51.api_key.to_s.empty?
        raise Tracking51::Tracking51Exception.new(Tracking51::Consts::ErrEmptyAPIKey)
      end

      url = get_request_url(path)

      headers = get_request_header(Tracking51.api_key)


      uri = URI.parse(url)

      if method.downcase == 'get' && params!=nil
        query_string = URI.encode_www_form(params)
        uri.query = query_string
      end

      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = uri.scheme == 'https'

      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.open_timeout = 10

      http.read_timeout = 10

      request_class = case method.downcase
                      when 'get' then Net::HTTP::Get
                      when 'post' then Net::HTTP::Post
                      when 'put' then Net::HTTP::Put
                      when 'delete' then Net::HTTP::Delete
                      else raise ArgumentError, "Invalid HTTP method: #{method}"
                      end

      request = request_class.new(uri.request_uri)

      headers.each { |key, value| request[key] = value }

      if  params!=nil && (method.downcase == 'post' || method.downcase == 'put')
        request.body = params.to_json
      end

      begin
        response = http.request(request)
        begin
          parsed_response = JSON.parse(response.body)
          parsed_response
        rescue JSON::ParserError
          response.body
        end
      rescue StandardError => e
        { 'error' => e.message }
      end
    end
  end
end