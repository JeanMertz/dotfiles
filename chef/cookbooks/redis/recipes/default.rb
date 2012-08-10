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

# Daemonize Redis
execute "sed -i -e 's/daemonize no/daemonize yes/' /usr/local/etc/redis.conf" do
  not_if { %x[cat /usr/local/etc/redis.conf].include?('daemonize yes') }
end

# Install prefPane
zip_app_package 'Redis' do
  source 'https://github.com/dquimper/Redis.prefPane/raw/master/Redis.prefPane.zip'
  extension 'prefPane'
end
