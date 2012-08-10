# Set formula
formula = 'firefox'
version = '15.0b3'

# Install package
dmg_package(formula) do
	source "http://pv-mirror02.mozilla.org/pub/mozilla.org/firefox/releases/#{version}/mac/nl/Firefox%20#{version}.dmg"
end
