# Set formula
formula = 'TextExpander'

# Install package
zip_app_package(formula) do
	source 'http://cdn.smilesoftware.com/TextExpander_3.4.2.zip'
end

# Start application
execute "open /Applications/#{formula}.app &>/dev/null" do
  only_if do
    %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? &&
    Time.now.to_i - File.stat("/Applications/#{formula}.app").mtime.to_i < 120
  end
end
