#!/usr/bin/env ruby -wKU
require "yaml"
require "net/http"
require "pry"

http_servers_config = File.expand_path("http_servers.yaml")

unless File.exist? http_servers_config
  puts "[Error] #{http_servers_config} http server config doesn't exist, please copy the sample one."
  exit
end

servers_yaml = YAML::load(File.open( http_servers_config ))

servers_yaml["servers"].each do |server|
  uri = "#{server["host"]}:#{server["port"] || 80}"
  puts "Connecting to #{uri}"
  begin
    # response = Net::HTTP.start(server["host"], server["port"], :read_timeout => 500) do |http|
    #   req = Net::HTTP::Get.new(uri)
    #   response = http.request(req)
    # end

    http = Net::HTTP.new(server["host"], server["port"])
    http.read_timeout = 5
    request = Net::HTTP::Get.new("/dashboard")
    response = http.request(request)

    puts "#{response.code} - #{response.message}"
  rescue SocketError
    puts " Name or service not known (SocketError)"
  rescue Errno::ECONNREFUSED
    puts " Connection refused"
  rescue Errno::ETIMEDOUT
    puts " Connection read_timeout"
  end
end
