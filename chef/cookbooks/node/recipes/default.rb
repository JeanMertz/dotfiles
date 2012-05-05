# Set formula
formula = 'node'

# Install package
package(formula)

# Install dependencies
execute "#{formula} Dependencies" do
	command 'curl http://npmjs.org/install.sh | sh'
	creates "#{node['homebrew_path']}/bin/npm"
end
