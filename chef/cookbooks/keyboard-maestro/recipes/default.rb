# Set formula
formula = 'Keyboard Maestro'

# Install package
zip_app_package(formula) do
	source 'http://files.stairways.com/keyboardmaestro-521.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
