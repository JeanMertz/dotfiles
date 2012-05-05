# Set formula
formula = 'redis'

# Install package
package(formula)

# Launch on startup
ruby_block "#{formula}_startup" do
	block do
	  formula_path = `brew info #{formula}`[node['homebrew_regex']]
		FileUtils.cp "#{formula_path}/homebrew.mxcl.#{formula}.plist", "#{node['home_path']}/Library/LaunchAgents/"
		%x[launchctl load -w #{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist]
	end
	not_if { File.exist?("#{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist") }
end
