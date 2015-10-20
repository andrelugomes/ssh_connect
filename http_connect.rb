#!/usr/bin/env ruby -wKU
require "yaml"
require "net/http"

http_servers_config = File.expand_path("http_servers.yaml")

unless File.exist? http_servers_config
  puts "[Error] #{http_servers_config} http server config doesn't exist, please copy the sample one."
  exit
end

servers_yaml = YAML::load(File.open( http_servers_config ))

servers_yaml["servers"].each do |server|
  uri = URI("#{server["host"]}")
  puts "Connecting to #{uri}"
  begin

    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 5
    http.open_timeout = 5
    resp = http.start() do |req|
      req.get(uri.path)
    end
    puts "#{resp.code} - #{resp.message}"
  rescue SocketError
    puts " Name or service not known (SocketError)"
  rescue Errno::ECONNREFUSED
    puts " Connection refused"
  rescue Errno::ETIMEDOUT
    puts " Connection read_timeout"
  rescue Net::OpenTimeout
    puts " Connection open_timeout"
  rescue Net::HTTPBadResponse
    puts " HTTPBadResponse"
  end
end
