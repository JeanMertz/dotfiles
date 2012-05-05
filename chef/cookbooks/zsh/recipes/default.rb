# Set formula
formula = 'zsh'

# Install package
package(formula) do
	options '--disable-etcdir'
end

# Set default shell
execute "#{formula}_default_shell" do
	code "chsh -s #{node['homebrew_path']}/bin/zsh"
	not_if { %x[echo $SHELL] == "#{node['homebrew_path']}/bin/zsh" }
end
