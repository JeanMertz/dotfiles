# Set formula
formula = 'Air Video Server'

# Install package
dmg_package(formula) do
	source 'https://s3.amazonaws.com/AirVideo/Air+Video+Server+2.4.5-beta7u1.dmg'
end

# Start application
execute "open '/Applications/#{formula}.app' &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
