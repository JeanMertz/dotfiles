# Install Steam from the dmg package
# We use a local (custom) package for now, because we can't
# accept the license agreement automatically.
formula = 'Steam'


dmg_package(formula) do
	source 'steam.dmg'
end
