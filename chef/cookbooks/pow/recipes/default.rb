# Can't install through homebrew, need HEAD

bash 'pow_install' do
	code "curl get.pow.cx | VERSION=0.4.0-pre sh"
	not_if { File.exists?('/Library/LaunchDaemons/cx.pow.firewall.plist') }
end