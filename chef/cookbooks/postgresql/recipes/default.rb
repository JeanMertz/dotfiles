# Set formula
formula = 'postgresql'

# Install package
package(formula)

# initialize database
execute "#{formula} initdb" do
	command "initdb #{node['homebrew_path']}/var/postgres"
	creates "#{node['homebrew_path']}/var/postgres"
end

# install dependencies
dmg_package 'Postgres' do
	source 'postgres.dmg'
	extension 'prefPane'
end

# install gem
gem_package 'pg'

# Launch on startup
ruby_block "#{formula}_startup" do
	block do
	  formula_path = `brew info #{formula}`[node['homebrew_regex']]
		%x[cp #{formula_path}/homebrew.mxcl.#{formula}.plist #{node['home_path']}/Library/LaunchAgents]
		%x[launchctl load -w #{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist]
	end
	not_if { File.exist?("#{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist") }
end
