# Set formula
formula = 'alfred'

# Install package
dmg_package(formula) do
	source 'http://rwc.cachefly.net/alfred_1.2_220.dmg'
end

# Start application
execute '/Applications/alfred.app &' do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
