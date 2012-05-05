# Set formula
formula = 'python'

# Install package
package(formula)

# Install pip (Package manager)
bash "#{formula}_pip" do
	code "#{node['homebrew_path']}/share/python/easy_install pip"
	code "#{node['homebrew_path']}/share/python/pip install --upgrade distribute"
	not_if { File.exist?("#{node['homebrew_path']}/share/python/pip") }
end

# Install virtualenv to also support Python 3
bash "#{formula}_virtualenv" do
	code 'pip install virtualenv'
	code 'pip install virtualenvwrapper'
	not_if { File.exist?("#{node['homebrew_path']}/share/python/virtualenv") }
end

# Add Python2 environment
bash "#{formula}_install_python2" do
	code ". '/usr/local/share/python/virtualenvwrapper.sh' && mkvirtualenv python"
	not_if { %x[. '/usr/local/share/python/virtualenvwrapper.sh' && lsvirtualenv -b].strip!.match(/^python$/) }
end

# Add Python3 environment
bash "#{formula}_install_python3" do
	code ". '#{node['homebrew_path']}/share/python/virtualenvwrapper.sh' && mkvirtualenv python3"
	not_if { %x[. '#{node['homebrew_path']}/share/python/virtualenvwrapper.sh' && lsvirtualenv -b].strip!.match(/^python3$/) }
end
