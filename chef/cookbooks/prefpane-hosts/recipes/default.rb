# Set file
version = '1.2'
file = "Hosts-#{version}.pkg"

execute 'Install prefPane' do
  %x[ wget -P "#{Chef::Config[:file_cache_path]}" https://github.com/downloads/specialunderwear/Hosts.prefpane/Hosts-#{version}.pkg ]
  %x[ sudo installer -pkg "#{Chef::Config[:file_cache_path]}/#{file}" -target / ]
end
