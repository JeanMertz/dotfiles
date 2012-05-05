# Set formula
formula = 'vim'
formula_path = `brew info #{formula}`[node['homebrew_regex']]

# Get homebrew/dupes
execute 'brew tap homebrew/dupes' do
	creates "#{node['homebrew_path']}/Library/Taps/homebrew-dupes"
end

# Install package
execute "brew install homebrew/dupes/#{formula}" do
	creates formula_path
end
