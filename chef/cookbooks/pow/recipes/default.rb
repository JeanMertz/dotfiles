
# # Normally this would work, but we need the latest version of Pow (pre-release)
# package 'pow'

# bash 'init_pow' do
# 	code 'sudo pow --install-system'
# 	code 'pow --install-local'
# end

bash 'install_pow' do
	code "curl get.pow.cx | VERSION=0.4.0-pre sh"
	not_if { File.exists?('/Library/LaunchDaemons/cx.pow.firewall.plist') }
end