# Set formula
formula = 'bash-completion'

# Install package
package(formula)

# Create symlinks
execute "#{formula} Symlinks" do
	command %(ln -s "#{node['application_support_path']}/Library/Contributions/brew_bash_completion.sh" "#{node['application_support_path']}/etc/bash_completion.d")
	creates "#{node['application_support_path']}/etc/bash_completion.d/brew_bash_completion.sh"
	only_if { File.exists?("#{node['application_support_path']}/Library/Contributions/brew_bash_completion.sh") }
end
