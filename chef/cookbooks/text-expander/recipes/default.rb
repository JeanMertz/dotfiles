# Set formula
formula = 'TextExpander'

# Install package
zip_app_package(formula) do
	source 'http://cdn.smilesoftware.com/TextExpander_3.4.2.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
