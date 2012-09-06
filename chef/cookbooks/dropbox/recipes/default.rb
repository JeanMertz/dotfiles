# Set formula
formula = 'Dropbox'

# Install package
dmg_package(formula) do
  source 'http://www.dropbox.com/download?plat=mac'
end

# Setup config
execute "#{formula} Config" do
  command <<-EOH
    open /Applications/Dropbox.app &
    echo "Please set up Dropbox (login and sync) and rerun Chef. The rest of this script needs access to the Dropbox folder."
    exit 1
  EOH
  creates "#{ENV['HOME']}/#{formula}"

  only_if do
    %x[ps ax | grep "#{formula}" | grep -v "grep"].empty? &&
    Time.now.to_i - File.stat("/Applications/#{formula}.app").mtime.to_i < 120
  end
end
