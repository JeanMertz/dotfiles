root_path = 			File.expand_path(File.join(File.dirname(__FILE__), '..'))
 
cookbook_path			File.join(root_path, 'cookbooks')
role_path				File.join(root_path, 'roles')
json_attribs			File.join(root_path, 'config/node.json')
 
state_root_path = 		File.expand_path('~/.dotfiles/chef/state')
file_cache_path			"#{state_root_path}/cache"
checksum_path			"#{state_root_path}/checksums"
sandbox_path			"#{state_root_path}/sandbox"
file_backup_path		"#{state_root_path}/backup"
cache_options[:path] = 	file_cache_path
