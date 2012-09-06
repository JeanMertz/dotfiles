# Set formula
formula = 'Flux'

# Install package
zip_app_package(formula) do
	source 'https://secure.herf.org/flux/Flux.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
  only_if do
    %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? &&
    Time.now.to_i - File.stat("/Applications/#{formula}.app").mtime.to_i < 120
  end
end
