dotfiles_path = File.join(File.dirname(__FILE__), '..', '..')
dropbox_path = `bash #{dotfiles_path}/utilities/get_dropbox_folder.sh`
application_support_path = "#{dotfiles_path}/Application Support"

name 'base'
override_attributes(
	dotfiles_path: dotfiles_path,
	dropbox_path: dropbox_path,
	application_support_path: application_support_path
)
