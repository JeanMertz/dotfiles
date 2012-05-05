# Set formula
formula = 'Sublime Text 2'

# Install package
dmg_package(formula) do
	source "#{formula}.dmg"
end

# install command line tool
bash "sublime_cli" do
	code 'ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl'
	not_if { File.exists?('/usr/local/bin/subl') }
end

# Unpack Application Support files if they don't exist
dmg_package "Application Support" do
	app 'Sublime Text 2'
	source 'Application Support.dmg'
	extension false
	destination node['application_support_path']
end

# symlink Application Support folder to dropbox
bash 'symlink_application_support' do
	code <<-EOH
		mkdir -p "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
		ln -s "#{node["application_support_path"]}/Sublime Text 2/Installed Packages" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
		ln -s "#{node["application_support_path"]}/Sublime Text 2/Packages" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
		ln -s "#{node["application_support_path"]}/Sublime Text 2/Pristine Packages" "#{ENV['HOME']}/Library/Application Support/Sublime Text 2/"
	EOH
	not_if { File.exists?("#{ENV['HOME']}/Library/Application Support/Sublime Text 2") }
end

# symlink license file
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
