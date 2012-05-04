# Install Steam from the dmg package
# We use a local (custom) package for now, because we can't
# accept the license agreement automatically.
dmg_package 'Steam' do
	source 'steam.dmg'
end
