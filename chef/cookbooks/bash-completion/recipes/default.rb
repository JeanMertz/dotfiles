# Set formula
formula = 'bash-completion'

# Install package
package(formula)

# Create symlinks
bash "#{formula}_symlinks" do
	code %(ln -s "#{node['application_support_path']}/Library/Contributions/brew_bash_completion.sh" "#{node['application_support_path']}/etc/bash_completion.d")
	only_if { File.exists?("#{node['application_support_path']}/Library/Contributions/brew_bash_completion.sh") && !File.exists?("#{node['application_support_path']}/etc/bash_completion.d/brew_bash_completion.sh") }
end
