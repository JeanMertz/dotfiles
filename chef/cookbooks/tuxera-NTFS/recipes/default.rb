# Set file
version = '2012.3.3'

dmg_package 'Tuxera_NTFS' do
  source "http://www.tuxera.com/mac/tuxerantfs_#{version}.dmg"
  execute true
  installed_resource "/Library/PreferencePanes/Tuxera NTFS.prefPane"
end


