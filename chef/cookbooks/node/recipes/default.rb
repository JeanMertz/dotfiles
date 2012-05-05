# Set formula
formula = 'node'

# Install package
package(formula)

# Install dependencies
bash "#{formula}_dependencies" do
	code 'curl http://npmjs.org/install.sh | sh'
	not_if { File.exist?("#{node['homebrew_path']}/bin/npm") }
end
