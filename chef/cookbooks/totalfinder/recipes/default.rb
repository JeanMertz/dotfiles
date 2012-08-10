# Install TotalFinder from the dmg package
version = '1.3.4'

dmg_package 'TotalFinder' do
  source "http://downloads-1.binaryage.com/TotalFinder-#{version}.dmg"
	extension 'mpkg'

	not_if { File.exist?('/Applications/TotalFinder.app') }
end
