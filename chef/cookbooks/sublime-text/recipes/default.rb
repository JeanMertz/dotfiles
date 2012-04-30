# only run this file if sublime.dmg exists. This will be changed in the future
# when Sublime Text 1.0/2.0 is released. After that, we wget the file remotely.
if File.exists?("#{ENV['HOME']}/.dotfiles/chef/cookbooks/sublime-text/files/default/sublime.dmg")

	# mount volume
	bash 'mount_volume' do
		cwd "#{ENV['HOME']}/.dotfiles/chef/cookbooks/sublime-text/files/default/"
		code 'hdiutil mount sublime.dmg'
		not_if { File.exists?('/Volumes/Sublime Text 2') || File.exists?('/Applications/Sublime Text 2.app') }
	end

	# install Sublime Text 2 (copy .app to /Applications)
	bash 'install_application' do
		code "cp -R '/Volumes/Sublime Text 2/Sublime Text 2.app' '/Applications/Sublime Text 2.app'"
		not_if { File.exists?('/Applications/Sublime Text 2.app') }
	end

	# unmount volume
	bash 'unmount_volume' do
		code 'hdiutil unmount "/Volumes/Sublime Text 2"'
		only_if { File.exists?('/Volumes/Sublime Text 2') }
	end

	# install subl command line tool
	bash 'install subl command' do
		code 'ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl'
		not_if { File.exists?('/usr/local/bin/subl') }
	end

	# symlink Application Support folder to dropbox
	bash 'symlink_application_support' do
		code <<-EOH
			mkdir -p "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
			ln -s "#{ENV['HOME']}/Dropbox/dotfiles/Application Support/Sublime Text 2/Installed Packages" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
			ln -s "#{ENV['HOME']}/Dropbox/dotfiles/Application Support/Sublime Text 2/Packages" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
			ln -s "#{ENV['HOME']}/Dropbox/dotfiles/Application Support/Sublime Text 2/Pristine Packages" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
		EOH
		not_if { File.exists?("#{ENV['HOME']}/Library/Application Support/Sublime Text 2") }
	end

	bash 'symlink_license' do
		code <<-EOH
			mkdir -p "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/Settings"
			ln -s "#{ENV['HOME']}/Dropbox/dotfiles/Application Support/Sublime Text 2/Settings/License.sublime_license" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/Settings"
		EOH
		only_if {
			File.exists?("#{ENV['HOME']}/Dropbox/dotfiles/Application Support/Sublime Text 2/Settings/License.sublime_license") &&
			! File.exists?("#{ENV['HOME']}/Library/Application Support/Sublime Text 2/Settings/License.sublime_license")
		}
	end

	# activate application (builds needed files)
	bash 'activate application' do
		code <<-EOH
			subl -b &
			sleep 2
			killall -KILL "Sublime Text 2"
		EOH
		not_if { File.exists?("#{ENV['HOME']}/Library/Application Support/Sublime Text 2/Settings/Session.sublime_session") }
	end
end