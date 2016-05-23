require 'pp'

class AcriveRecordSmtpServer < MiniSmtpServer

  def new_message_event(message_hash)
    row = {}
    row[:raw_from] = message_hash[:from]
    row[:raw_to] = message_hash[:to]
    headers, body = message_hash[:data].split("\r\n\r\n")
    row[:headers] = {}
    headers.split("\r\n").map{|pair| k, v = pair.split(':'); { k.strip => v.strip }}.each{|h| row[:headers][h.keys.first] = h.values.first}
    row[:body] = body
    row[:subject] = row[:headers]['Subject']
    row[:from] = row[:headers]['From']
    row[:to] = row[:headers]['To']
    row[:inbox] = row[:headers]['To'].match(/[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i)[0].split('@').first
    row[:headers] = row[:headers].to_json
    
    pp row
    puts ''

    #puts "-- From: #{message_hash[:from]}"
    #puts "-- To:   #{message_hash[:to]}"
    #puts "--"
    #puts "-- " + message_hash[:data].gsub(/\r\n/, "\r\n-- ")
    #puts ""
  end
end

server = AcriveRecordSmtpServer.new(25, "0.0.0.0", 20)
server.start
server.join

#puts "just terminating"
#$server.shutdown
#while($server.connections > 0)
#  sleep 0.01
#end
#$server.stop
#$server.join
