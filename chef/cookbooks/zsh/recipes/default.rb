# Set formula
formula = 'zsh'

# Install package
package(formula) do
	options '--disable-etcdir'
end

# Add zsh as login shell
execute "#{formula}_login_shell" do
	command "echo #{node['homebrew_path']}/bin/zsh | sudo tee -a /etc/shells"
	only_if { %x[cat /etc/shells | grep ^#{node['homebrew_path']}/bin/zsh$].empty? }
end

# Set default shell
execute "#{formula}_default_shell" do
	command "chsh -s #{node['homebrew_path']}/bin/zsh"
	not_if { %x[echo $SHELL].strip == "#{node['homebrew_path']}/bin/zsh" }
end
