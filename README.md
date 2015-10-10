# SSH Connect Test

## Why?

Connection test for a lot of server with ssh.

Today there are:
 - 23 productions server
 - 18 staging servers
 - 12 qa servers
 - 0 development servers

# First

```bash
    git clone git@github.com:andrelugomes/ssh_connect.git
    cp .env.sample .env
    cp servers.yaml.sample servers.yaml
    bundle install
 ```
 Set up your USER and PASS in .env
 
 Set up your Servers list in servers.yaml
 
# Run

```bash
bundle exec ruby ssh_connect.rb
```