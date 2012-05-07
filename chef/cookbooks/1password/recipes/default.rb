# Set formula
formula = '1password'

# Install package
zip_app_package(formula) do
	source 'https://d13itkw33a7sus.cloudfront.net/dist/1P/mac/1Password-3.8.19.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
