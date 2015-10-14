# Conection Test for HTTP and SSH Servers

## Why?

Connection test for a lot of server with SSH and HTTP VIPs.

Today there are:
 - 23 productions server
 - 18 staging servers
 - 12 qa servers
 - 0 development servers

# First

```bash
    git clone git@github.com:andrelugomes/ssh_connect.git
    cp .env.sample .env
    cp ssh_servers.yaml.sample ssh_servers.yaml
    cp http_servers.yaml.sample http_servers.yaml
    bundle install
 ```
 Set up your USER and PASS in .env
 
 Set up your SSH Servers list in ssh_servers.yaml

 Set up your HTTP Servers list in http_servers.yaml
 
# Run

## SSH conection test
```bash
bundle exec ruby ssh_connect.rb
```

## HTTP conection test
```bash
bundle exec ruby http_connect.rb
```