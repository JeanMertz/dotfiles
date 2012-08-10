# This is a local DNS server used to catch the *.test domain and reroute its
# requests to localhost. This allows us to use app.test when doing integration
# tests in RSpec and/or Cucumber. This is especially recommended when using
# subdomain specific features that need testing.
#
# Also, OpenDNS is used as the default DNS when accessing the www.

# Set formula
formula = 'dnsmasq'

# Install package
package(formula)

# Setup resolv
execute "#{formula} Config" do
	command %(echo "
# Default:
# 212.54.40.25
# 212.54.35.25
#
# OpenDNS IPv6:
nameserver 2620:0:ccc::2
nameserver 2620:0:ccd::2
#
# OpenDNS:
nameserver 208.67.222.222
nameserver 208.67.220.220
#
# Google:
nameserver 8.8.8.8
nameserver 8.8.4.4
#
# Google IPv6:
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844" > /usr/local/etc/resolv.dnsmasq.conf)
	creates '/usr/local/etc/resolv.dnsmasq.conf'
end

# Setup config
execute "#{formula} Config" do
	command %(echo "
bogus-priv
strict-order
domain-needed
resolv-file=/usr/local/etc/resolv.dnsmasq.conf
address=/test/127.0.0.1
listen-address=127.0.0.1" > /usr/local/etc/dnsmasq.conf)
	creates '/usr/local/etc/dnsmasq.conf'
end

# Make sure OS X only uses dnsmasq nameservers
execute "echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf" do
	not_if { %x[cat /etc/resolv.conf].match(/^(domain localdomain|nameserver 127.0.0.1)$/) }
end

# Launch on startup
ruby_block "#{formula} Startup" do
	block do
	  formula_path = `brew info #{formula}`[node['homebrew_regex']]
		%x[sudo cp #{formula_path}/homebrew.mxcl.#{formula}.plist /Library/LaunchDaemons]
		%x[launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.#{formula}.plist]
	end
	not_if { File.exist?("/Library/LaunchDaemons/homebrew.mxcl.#{formula}.plist") }
end
