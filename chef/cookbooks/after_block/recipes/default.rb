# Clean __MACOSX file in temp directory
ruby_block "clean_cache_path" do
  block do
    %x[rm -f -R #{Chef::Config[:file_cache_path]}]
  end
end
