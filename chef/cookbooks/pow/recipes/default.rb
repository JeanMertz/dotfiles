# Can't install through homebrew, need HEAD
execute 'curl get.pow.cx | sh' do
	creates '/Library/LaunchDaemons/cx.pow.firewall.plist'
end
