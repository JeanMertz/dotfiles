# Set formula
formula = 'alfred'
version = '1.3.1_261'

# Install package
dmg_package(formula) do
	source "http://rwc.cachefly.net/alfred_#{version}.dmg"
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
