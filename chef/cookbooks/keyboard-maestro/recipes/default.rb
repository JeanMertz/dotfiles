# Set formula
formula = 'Keyboard Maestro'
version = '532'

# Install package
zip_app_package(formula) do
  source "http://files.stairways.com/keyboardmaestro-#{version}.zip"
end

# Start application
execute "open '/Applications/#{formula}.app' &>/dev/null" do
	only_if { %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? }
end
