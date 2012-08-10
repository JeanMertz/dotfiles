# Set formula
formula = 'VLC'
version = '2.0.3'

# Install package
dmg_package(formula) do
	dmg_name "vlc-#{version}"
	source "http://dfn.dl.sourceforge.net/project/vlc/#{version}/macosx/vlc-#{version}.dmg"
end
