# Install TotalFinder from the dmg package
dmg_package 'TotalFinder' do
	source 'http://downloads-1.binaryage.com/TotalFinder-1.3.4.dmg'
	extension 'mpkg'

	not_if { File.exist?('/Applications/TotalFinder.app') }
end
