# Install Python 2.x
package 'python'

# Install pip (Package manager)
bash 'install_pip' do
	code '/usr/local/share/python/easy_install pip'
	code '/usr/local/share/python/pip install --upgrade distribute'
	not_if { File.exist?('/usr/local/share/python/pip') }
end

# Install virtualenv to also support Python 3
bash 'install_virtualenv' do
	code 'pip install virtualenv'
	code 'pip install virtualenvwrapper'
	not_if { File.exist?('/usr/local/share/python/virtualenv') }
end

# Add Python2 environment
bash 'install_python2' do
	code ". '/usr/local/share/python/virtualenvwrapper.sh' && mkvirtualenv python"
	not_if { %x[. '/usr/local/share/python/virtualenvwrapper.sh' && lsvirtualenv -b].strip!.match(/^python$/) }
end

# Add Python3 environment
bash 'install_python3' do
	code ". '/usr/local/share/python/virtualenvwrapper.sh' && mkvirtualenv python3"
	not_if { %x[. '/usr/local/share/python/virtualenvwrapper.sh' && lsvirtualenv -b].strip!.match(/^python3$/) }
end
