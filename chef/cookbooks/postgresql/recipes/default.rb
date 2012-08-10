# Set formula
formula = 'postgresql'
prefpane_version = '0.0.3'

# Install package
package(formula)

# initialize database
execute "#{formula} initdb" do
	command "initdb #{node['homebrew_path']}/var/postgres"
	creates "#{node['homebrew_path']}/var/postgres"
end

zip_app_package 'Postgres' do
  source "https://github.com/downloads/jwang/pgpane/Postgres.prefPane_v#{prefpane_version}.zip"
  extension 'prefPane'
end

# install gem
execute 'install pg' do
	command 'env ARCHFLAGS="-arch x86_64" gem install pg --no-ri --no-rdoc'
	only_if { %x[gem which pg | grep 'pg'].empty? }
end

# Launch on startup
ruby_block "#{formula}_startup" do
	block do
	  formula_path = `brew info #{formula}`[node['homebrew_regex']]
		%x[cp #{formula_path}/homebrew.mxcl.#{formula}.plist #{node['home_path']}/Library/LaunchAgents]
		%x[launchctl load -w #{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist]
	end
	not_if { File.exist?("#{node['home_path']}/Library/LaunchAgents/homebrew.mxcl.#{formula}.plist") }
end
