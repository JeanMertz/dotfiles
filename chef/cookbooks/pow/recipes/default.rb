# Can't install through homebrew, need HEAD
execute 'curl get.pow.cx | VERSION=0.4.0-pre sh' do
	creates '/Library/LaunchDaemons/cx.pow.firewall.plist'
end
