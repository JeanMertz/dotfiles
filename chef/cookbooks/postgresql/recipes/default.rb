# install postgresql
package 'postgresql'

# initialize database
execute 'initdb' do
	command 'initdb /usr/local/var/postgres'
	creates '/usr/local/var/postgres'
end

# install postgres prefpane
dmg_package 'Postgres' do
	source 'postgres.dmg'
	extension 'prefPane'
end
# install pg gem to work with postgresql
gem_package 'pg'
