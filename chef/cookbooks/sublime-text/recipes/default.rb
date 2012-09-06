# Set formula
formula = 'Sublime Text 2'
version = '2218'

# Install package
dmg_package(formula) do
  source "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202%20Build%20#{version}.dmg"
end

# install command line tool
execute "#{formula} Installation" do
  command 'ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl'
  creates '/usr/local/bin/subl'
end

# symlink Application Support folder to dropbox
execute "#{formula} Symlinks" do
  command <<-EOH
    mkdir -p "#{node["home_path"]}/Library/Application Support/Sublime Text 2/"
    ln -s "#{node["application_support_path"]}/Sublime Text 2/Installed Packages" "#{node["home_path"]}/Library/Application Support/Sublime Text 2/"
    ln -s "#{node["application_support_path"]}/Sublime Text 2/Packages" "#{node["home_path"]}/Library/Application Support/Sublime Text 2/"
    ln -s "#{node["application_support_path"]}/Sublime Text 2/Pristine Packages" "#{node["home_path"]}/Library/Application Support/Sublime Text 2/"
  EOH
  creates "#{node["home_path"]}/Library/Application Support/Sublime Text 2"
end

# symlink license file
execute "#{formula} License" do
  command <<-EOH
    mkdir -p "#{node["home_path"]}/Library/Application Support/Sublime Text 2/Settings"
    ln -s "#{node["home_path"]}/Dropbox/dotfiles/Application Support/Sublime Text 2/Settings/License.sublime_license" "#{node["home_path"]}/Library/Application Support/Sublime Text 2/Settings"
  EOH
  creates "#{node["home_path"]}/Library/Application Support/Sublime Text 2/Settings/License.sublime_license"
  only_if { File.exists?("#{node["home_path"]}/Dropbox/dotfiles/Application Support/Sublime Text 2/Settings/License.sublime_license") }
end
