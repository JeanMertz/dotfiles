# Set formula
formula = 'python'

# Install package
package(formula)

# Install pip (Package manager)
bash "#{formula} pip" do
  code <<-EOH
  #{node['homebrew_path']}/share/python/easy_install pip
	#{node['homebrew_path']}/share/python/pip install --upgrade distribute
  EOH
	not_if { File.exist?("#{node['homebrew_path']}/share/python/pip") }
end

# Install virtualenv to also support Python 3
execute 'pip install virtualenv' do
  creates "#{node['homebrew_path']}/share/python/virtualenv"
end

# Install virtualenvwrapper for easy env management
execute 'pip install virtualenvwrapper' do
  creates "#{node['homebrew_path']}/share/python/virtualenvwrapper.sh"
end

# Add Python2 environment
execute "#{formula} Install Python2" do
	command ". '/usr/local/share/python/virtualenvwrapper.sh' && mkvirtualenv python"
	not_if { %x[. '/usr/local/share/python/virtualenvwrapper.sh' && lsvirtualenv -b].strip!.match(/^python$/) }
end

# Add Python3 environment
execute "#{formula} Install Python3" do
	command ". '#{node['homebrew_path']}/share/python/virtualenvwrapper.sh' && mkvirtualenv python3"
	not_if { %x[. '#{node['homebrew_path']}/share/python/virtualenvwrapper.sh' && lsvirtualenv -b].strip!.match(/^python3$/) }
end
