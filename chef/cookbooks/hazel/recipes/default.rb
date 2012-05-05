# Set formula
formula = 'hazel'

# Install package
dmg_package(formula) do
	source 'hazel.dmg'
	extension 'prefPane'
end

# Create symlinks
bash "#{formula}_symlinks" do
	code %(mkdir -p "#{node['application_support_path']}/Hazel")
	code %(ln -s "#{node['application_support_path']}/Hazel/license" "#{ENV['HOME']}/Library/Application Support/Hazel")
	only_if { File.exists?("#{node['application_support_path']}/Hazel/license") && !File.exists?("#{ENV['HOME']}/Library/Application Support/Hazel") }
end
