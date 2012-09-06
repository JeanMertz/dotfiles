version = '2.51'

# Install Transmission from the dmg package
dmg_package 'Transmission' do
	source "http://download.transmissionbt.com/files/Transmission-#{version}.dmg"
end
