# Set formula
formula = 'dnsmasq'

# Install package
package(formula)

# Setup config
bash "#{formula}_config" do
	code %(echo "domain-needed\naddress=/*.test/127.0.0.1" > /usr/local/etc/dnsmasq.conf)
	not_if { File.exist?('/usr/local/etc/dnsmasq.conf') }
end

# Launch on startup
ruby_block "#{formula}_startup" do
	formula_path = `brew info #{formula}`[node['homebrew_regex']]

	block do
		%x[sudo cp #{formula_path}/homebrew.mxcl.dnsmasq.plist /Library/LaunchAgents/]
		%x[launchctl load -w /Library/LaunchAgents/homebrew.mxcl.dnsmasq.plist]
	end
	not_if { File.exist?("/Library/LaunchAgents/homebrew.mxcl.dnsmasq.plist") }
end
