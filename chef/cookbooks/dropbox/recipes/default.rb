unless File.exists?('/Applications/Dropbox.app')
	# download dropbox
	bash 'download_dropbox' do
		code 'curl -L -o Dropbox.dmg https://www.dropbox.com/download?plat=mac'
		not_if { File.exists?('Dropbox.dmg') }
	end

	# mount volume
	bash 'mount_volume' do
		code 'hdiutil mount Dropbox.dmg'
		not_if { File.exists?('/Volumes/Dropbox Installer') }
	end

	# install Dropbox (copy .app to /Applications)
	bash 'install_application' do
		code "cp -R '/Volumes/Dropbox Installer/Dropbox.app' '/Applications/Dropbox.app'"
	end

	# unmount volume
	bash 'unmount_volume' do
		code 'hdiutil unmount "/Volumes/Dropbox Installer"'
		only_if { File.exists?('/Volumes/Dropbox Installer') }
	end

	# delete dropbox file
	bash 'unmount_volume' do
		code 'rm Dropbox.dmg'
		only_if { File.exists?('Dropbox.dmg') }
	end
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