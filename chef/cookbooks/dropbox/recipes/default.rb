# Set formula
formula = 'Dropbox'

# Install package
dmg_package(formula) do
	source 'http://www.dropbox.com/download?plat=mac'
end

# Setup config
bash "#{formula}_config" do
	code <<-EOH
		open /Applications/Dropbox.app &
		echo "Please set up Dropbox (login and sync) and rerun Chef. The rest of this script needs access to the Dropbox folder."
		exit 1
	EOH
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? || ! File.exist?("#{ENV['HOME']}/#{formula}") }
end
