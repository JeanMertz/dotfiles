# Set formula
formula = 'Tower'
version = '1.4.11'

# Install package
zip_app_package(formula) do
	zip_file "Tower-#{version}.zip"
	source 'https://macapps.fournova.com/tower1-1060/download'
end
