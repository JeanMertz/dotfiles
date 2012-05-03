package 'readline' do
	not_if { File.directory?("#{`brew --prefix`.strip!}/Cellar/readline") }
end

bash 'unlink_readline' do
	code 'brew unlink readline'
	only_if { File.directory?("#{`brew --prefix`.strip!}/include/readline") }
end
