# Install Screens Connect from the dmg package
dmg_package 'Screens Connect' do
	dmg_name 'screensconnect'
	source 'https://screensconnect.com/downloads/screensconnect.dmg'
	extension 'pkg'

	not_if { File.exist?("#{node['root_prefpanes_path']}/Screens Connect.prefPane") }
end

# Open custom port for SSH connection
bash 'Add SHH Port' do

	code <<-EOH
	if [ -f /usr/libexec/PlistBuddy ]; then
		sudo /usr/libexec/PlistBuddy -c "Copy :Sockets:Listeners :Sockets:ListenersCustom" /System/Library/LaunchDaemons/ssh.plist
		sudo /usr/libexec/PlistBuddy -c "Set :Sockets:ListenersCustom:Bonjour:0 2002" /System/Library/LaunchDaemons/ssh.plist
		sudo /usr/libexec/PlistBuddy -c "Set :Sockets:ListenersCustom:SockServiceName 2002" /System/Library/LaunchDaemons/ssh.plist

		sudo /usr/libexec/PlistBuddy -c "Copy :Sockets:Listeners :Sockets:ListenersCustom2" /System/Library/LaunchDaemons/ssh.plist
		sudo /usr/libexec/PlistBuddy -c "Set :Sockets:ListenersCustom2:Bonjour:0 2001" /System/Library/LaunchDaemons/ssh.plist
		sudo /usr/libexec/PlistBuddy -c "Set :Sockets:ListenersCustom2:SockServiceName 2001" /System/Library/LaunchDaemons/ssh.plist
	fi
	EOH

	only_if { %x[cat /System/Library/LaunchDaemons/ssh.plist | grep \\<string\\>2002\\</string\\>].empty? }

end
