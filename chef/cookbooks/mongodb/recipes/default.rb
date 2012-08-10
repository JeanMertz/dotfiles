# Set formula
formula = 'mongodb'
prefpane_version = '0.1.1'

# Install package
package(formula)

zip_app_package 'mongo' do
	# Not working, see: http://tickets.opscode.com/browse/CHEF-3349
  # source "https://github.com/downloads/ivanvc/mongodb-prefpane/mongodb.prefpane%20#{prefpane_version}.zip"
  source "mongodb.prefpane #{prefpane_version}.zip"
  extension 'prefPane'
end

# install gem
gem_package 'mongoid'

# Launch on startup
ruby_block "#{formula}_startup" do
	block do
	  formula_path = `brew info #{formula}`[node['homebrew_regex']]
		%x[cp #{formula_path}/homebrew.mxcl.#{formula}.plist #{node['home_path']}/Library/LaunchAgents]
		%x[launchctl load -w #{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist]
	end
	not_if { File.exist?("#{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist") }
end
