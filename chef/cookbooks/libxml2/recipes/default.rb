package 'libxml2' do
	not_if { File.directory?("#{`brew --prefix`.strip!}/Cellar/libxml2") }
end

bash 'unlink_libxml2' do
	code 'brew unlink libxml2'
	only_if { File.directory?("#{`brew --prefix`.strip!}/include/libxml2") }
end
