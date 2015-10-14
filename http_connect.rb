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
    req = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(server["host"], server["port"], :read_timeout => 500) do |http|
      response = http.request(req)
    end
    puts response.code
  rescue SocketError
    puts " Name or service not known (SocketError)"
  rescue Errno::ECONNREFUSED
    puts " Connection refused"
  end
end
