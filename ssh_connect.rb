#!/usr/bin/env ruby -wKU
require "yaml"
require "dotenv"
require "net/ssh"

server_config = File.expand_path("servers.yaml")

Dotenv.load

unless File.exist? server_config
  puts "[Error] #{server_config} server config doesn't exist, please copy the sample one."
  exit
end

servers_yaml = YAML::load(File.open( server_config ))
servers = servers_yaml["servers"]

servers.each do |server|
  user = server["user"] || ENV['SSH_USER']
  pass = server["pass"] || ENV['SSH_PASSWORLD']

  puts "Connecting to #{server["alias"]} with #{user}@#{server["host"]} port #{server["port"] || 22}"
  begin
    # Net::SSH.start(server["host"], user,:password => pass, :timeout => 5) do |ssh|
    #     ssh.exec!("exit")
    # end
    Net::SSH.start(server["host"], user,:password => pass, :timeout => 5) do |session|
      puts " Ok"
      session.close
    end

  rescue SocketError
    puts " Name or service not known (SocketError)"
  rescue Net::SSH::ConnectionTimeout
    puts " Connection timeout"
  rescue Net::SSH::AuthenticationFailed
    puts " Authentication failure"
  rescue Net::SSH::KnownHosts
    puts " Name or service not known"
  rescue Net::SSH::Authentication::DisallowedMethod
    puts " Permission Denied"
  rescue Errno::ECONNREFUSED
    puts " Connection refused"
  end
  #system "sshpass -p '#{pass}' ssh #{user}@#{server["host"]} -p #{server["port"] || 22} exit"
end
