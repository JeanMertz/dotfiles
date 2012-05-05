# Set formula
formula = 'hazel'

# Install package
dmg_package(formula) do
	source 'hazel.dmg'
	extension 'prefPane'
end

# Create symlinks
execute "#{formula} Symlinks" do
	command %(mkdir -p "#{node['application_support_path']}/Hazel")
	command %(ln -s "#{node['application_support_path']}/Hazel/license" "#{ENV['HOME']}/Library/Application Support/Hazel")
	creates "#{ENV['HOME']}/Library/Application Support/Hazel"
	only_if { File.exists?("#{node['application_support_path']}/Hazel/license") }
end
