# Instlal dnsmasq
package 'dnsmasq'

# Setup correct dnsmasq.conf settings
bash 'dnsmasq_config' do
	code %(echo "domain-needed\naddress=/*.test/127.0.0.1" > /usr/local/etc/dnsmasq.conf)
	not_if { File.exist?('/usr/local/etc/dnsmasq.conf') }
end

# Make sure dnsmasq launches on startup
ruby_block 'dnsmasq_startup' do
	block do
		unless File.exist?('/Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist')
			%x[sudo cp /usr/local/Cellar/dnsmasq/2.61/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons]
			%x[sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist]
		end
	end
end
