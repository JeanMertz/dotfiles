# Set formula
formula = 'Flux'

# Install package
zip_app_package(formula) do
	source 'https://secure.herf.org/flux/Flux.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
