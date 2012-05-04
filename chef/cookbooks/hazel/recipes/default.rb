# install Hazel prefpane
dmg_package 'Hazel' do
	source 'hazel.dmg'
	extension 'prefPane'
end

# symlink license file
bash 'symlink_license' do
	code 'mkdir -p "#{application_support_path}/Hazel"'
	code %(ln -s "#{application_support_path}/Hazel/license" "#{ENV['HOME']}/Library/Application Support/Hazel")
	only_if { File.exists?("#{application_support_path}/Hazel/license") && !File.exists?("#{ENV['HOME']}/Library/Application Support/Hazel") }
end
