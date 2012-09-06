# Set file
version = '2012.3.3'

dmg_package 'Tuxera_NTFS' do
  app 'Install Tuxera NTFS'
  dmg_name "Tuxera NTFS #{version}"
  source "http://www.tuxera.com/mac/tuxerantfs_#{version}.dmg"
  execute true
  installed_resource "/Library/PreferencePanes/Tuxera NTFS.prefPane"
end


