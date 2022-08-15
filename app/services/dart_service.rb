require 'faraday'
require 'faraday/net_http'
require 'nokogiri'

class DartService
  attr_reader :conn
  
  def initialize
    @conn = Faraday.new('http://api.irishrail.ie/realtime/realtime.asmx')
    conn.adapter Faraday.default_adapter
  end

  def destinations
    response = conn.get('getAllStationsXML')
    json_response = Hash.from_xml(response.body)
    json_response['ArrayOfObjStation']['objStation']
  end

  def next_trains(station)
    response = conn.get("getStationDataByNameXML?StationDesc=#{station}")
    json_response = Hash.from_xml(response.body)
    json_response['ArrayOfObjStationData']['objStationData']
  end
end
