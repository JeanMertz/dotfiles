# Set formula
formula = 'vim'
formula_path = `brew info #{formula}`[node['homebrew_regex']]

# Get homebrew/dupes
execute 'brew tap homebrew/dupes' do
	not_if { File.exist?("#{node['homebrew_path']}/Library/Taps/homebrew-dupes") }
end

# Install package
execute "brew install homebrew/dupes/#{formula}" do
	not_if { File.exist?(formula_path) }
end
