package 'curl' do
	not_if { File.directory?("#{`brew --prefix`.strip!}/Cellar/curl") }
end

bash 'unlink_curl' do
	code 'brew unlink curl'
	only_if { File.directory?("#{`brew --prefix`.strip!}/include/curl") }
end
