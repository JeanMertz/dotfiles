# Set formula
formula = 'hazel'
version = '3.0.10'

# Install package
dmg_package(formula) do
  source "https://s3.amazonaws.com/Noodlesoft/Hazel-#{version}.dmg"
  volumes_dir 'Hazel'
	extension 'prefPane'
end

# Create symlinks
execute "#{formula} Symlinks" do
	command %(mkdir -p "#{node['application_support_path']}/Hazel")
	command %(ln -s "#{node['application_support_path']}/Hazel/license" "#{ENV['HOME']}/Library/Application Support/Hazel")
	creates "#{ENV['HOME']}/Library/Application Support/Hazel"
	only_if { File.exists?("#{node['application_support_path']}/Hazel/license") }
end
