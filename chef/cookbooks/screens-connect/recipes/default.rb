# Install Screens Connect from the dmg package
dmg_package 'Screens Connect' do
	dmg_name 'screensconnect'
	source 'https://screensconnect.com/downloads/screensconnect.dmg'
	extension 'pkg'

	not_if { File.exist?("#{node['root_prefpanes_path']}/Screens Connect.prefPane") }
end
