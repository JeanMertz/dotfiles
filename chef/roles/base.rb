dotfiles_path = File.join(File.dirname(__FILE__), '..', '..')
dropbox_path = `bash #{dotfiles_path}/utilities/get_dropbox_folder.sh`
application_support_path = "#{dotfiles_path}/Application Support"

name 'base'
override_attributes(
	home_path: ENV['HOME'],
	homebrew_path: `brew --prefix`.strip!,
	homebrew_regex: /^#{`brew --prefix`.strip!}\/Cellar(?:(?! \(\d+ files?).)+/i,
	prefpanes_path: "#{ENV['HOME']}/Library/PreferencePanes",
	root_prefpanes_path: "/Library/PreferencePanes",
	dotfiles_path: dotfiles_path,
	dropbox_path: dropbox_path,
	application_support_path: application_support_path
)
