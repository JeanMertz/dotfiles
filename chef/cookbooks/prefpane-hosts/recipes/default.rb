# Set file
version = '1.2'
file = "Hosts-#{version}.pkg"

ruby_block 'hosts prefPane' do
  block do
    %x[ wget -P "#{Chef::Config[:file_cache_path]}" https://github.com/downloads/specialunderwear/Hosts.prefpane/Hosts-#{version}.pkg ]
    %x[ sudo installer -pkg "#{Chef::Config[:file_cache_path]}/#{file}" -target / ]
  end

  not_if { File.exist?("#{node['root_prefpanes_path']}/Hosts.prefPane") }
end
