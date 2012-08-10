# Set formula
formula = 'Air Video Server'
version = '2.4.6-beta3'

# Install package
dmg_package(formula) do
  source "http://s3.amazonaws.com/AirVideo/Air+Video+Server+#{version}.dmg"
end

# Start application
execute "open '/Applications/#{formula}.app' &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
