# Set formula
formula = 'readline'
formula_path = `brew info #{formula}`[node['homebrew_regex']] || ""

# Install package
package(formula) do
	not_if { File.exist?(formula_path) }
end

# Unlink package
execute "#{formula} Unlink" do
	command "brew unlink #{formula}"
	only_if { File.exist?("#{node['homebrew_path']}/include/#{formula}") }
end
