# Set formula
formula = 'vim'

# Get homebrew/dupes
execute 'brew tap homebrew/dupes' do
	not_if { File.exist?("#{node['homebrew_path']}/Library/Taps/homebrew-dupes") }
end

# Install package
package("homebrew/dupes/#{formula}")
