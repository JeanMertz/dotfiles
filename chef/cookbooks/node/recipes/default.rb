# Set formula
formula = 'node'

# Install package
package(formula)

# Install dependencies
execute "#{formula} Dependencies" do
	command 'curl https://npmjs.org/install.sh | sudo sh'
	creates "#{node['homebrew_path']}/bin/npm"
end
