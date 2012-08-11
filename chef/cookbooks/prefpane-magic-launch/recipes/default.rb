# Set file
version = '1.4.3'

zip_app_package 'Magic Launch' do
  # Not working, see: http://tickets.opscode.com/browse/CHEF-3349
  # source "https://github.com/downloads/ivanvc/mongodb-prefpane/mongodb.prefpane%20#{prefpane_version}.zip"
  source "https://www.metakine.com/files/Magic%20Launch%20v#{version}.zip"
  extension 'prefPane'
end
