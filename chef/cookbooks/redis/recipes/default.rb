# Set formula
formula = 'redis'

# Install package
package(formula)

# Launch on startup
ruby_block "#{formula}_startup" do
	formula_path = `brew info #{formula}`[node['homebrew_regex']]

	block do
		FileUtils.cp "#{formula_path}/homebrew.mxcl.redis.plist", "#{node['home_path']}/Library/LaunchAgents/"
		%x[launchctl load -w #{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.redis.plist]
	end
	not_if { File.exist?("#{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.redis.plist") }
end
