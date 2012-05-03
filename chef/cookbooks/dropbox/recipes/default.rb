# Install Dropbox from the dmg package
dmg_package 'Dropbox' do
	source 'http://www.dropbox.com/download?plat=mac'
end

# open dropbox and wait for user to set up dropbox
bash 'setup_dropbox' do
	code <<-EOH
		open /Applications/Dropbox.app &
		echo "Please set up Dropbox (login and sync) and rerun Chef. The rest of this script needs access to the Dropbox folder."
		exit 1
	EOH
	only_if { %x[ps ax | grep "Dropbox" | grep -v "grep"].empty? || ! File.exists?("#{ENV['HOME']}/Dropbox") }
end