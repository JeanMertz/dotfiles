# Set formula
formula = 'BetterTouchTool'

# Install package
zip_app_package(formula) do
	source 'http://www.boastr.de/BetterTouchTool.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
