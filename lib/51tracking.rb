$:.unshift File.dirname(__FILE__)

require '51tracking/const'
require '51tracking/exception'
require '51tracking/courier'
require '51tracking/tracking'
require '51tracking/air_waybill'

module Tracking51
  class << self
    attr_accessor :api_key
  end

  VERSION = '0.1.2'
end

