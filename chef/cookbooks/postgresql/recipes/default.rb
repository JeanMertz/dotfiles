include_recipe 'homebrew'

# install postgresql
package 'postgresql'

# initialize database
execute 'initdb' do
	command 'initdb /usr/local/var/postgres'
	creates '/usr/local/var/postgres'
end

# install postgres prefpane
remote_directory '/Users/Jean/Library/PreferencePanes/Postgres.prefPane' do
	source 'Postgres.prefPane'
end

# install pg gem to work with postgresql
gem_package 'pg'
