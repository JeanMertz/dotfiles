# Set formula
formula = 'Backblaze Installer'

# Install package
dmg_package(formula) do
  dmg_name 'install_backblaze-af0071cf582'
  execute true
	source 'https://secure.backblaze.com/mac/install_backblaze.dmg'
end
