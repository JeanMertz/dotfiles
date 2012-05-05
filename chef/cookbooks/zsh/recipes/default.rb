# Set formula
formula = 'zsh'

# Install package
package(formula) do
	options '--disable-etcdir'
end

# Add zsh as login shell
execute "#{formula} Login shell" do
	command "echo #{node['homebrew_path']}/bin/zsh | sudo tee -a /etc/shells"
	only_if { %x[cat /etc/shells | grep ^#{node['homebrew_path']}/bin/zsh$].empty? }
end

# Set default shell
execute "#{formula} Default shell" do
	command "chsh -s #{node['homebrew_path']}/bin/zsh"
	not_if { %x[dscl . -read #{ENV['HOME']} UserShell].strip.match("#{node['homebrew_path']}/bin/zsh$") }
end
