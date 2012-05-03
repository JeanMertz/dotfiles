# set default os x configuration
# credits to https://github.com/mathiasbynens/dotfiles for original inspiration
commands = [
	{
		'name' => 			'keyboard_ui',
		'description' =>	'Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)',
		'key' => 			'NSGlobalDomain AppleKeyboardUIMode',
		'type' => 			'int',
		'value' => 			'3'
	},
	{
		'name' => 			'font_smoothing',
		'description' =>	'Enable subpixel font rendering on non-Apple LCDs',
		'key' => 			'NSGlobalDomain AppleFontSmoothing',
		'type' => 			'int',
		'value' => 			'2'
	},
	{
		'name' => 			'dock_autohide',
		'description' =>	'Automatically hide and show the Dock',
		'key' => 			'com.apple.dock autohide',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'menubar_transparency',
		'description' =>	'Disable menu bar transparency',
		'key' => 			'NSGlobalDomain AppleEnableMenuBarTransparency',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'finder_quit_menu_item',
		'description' =>	'Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons',
		'key' => 			'com.apple.finder QuitMenuItem',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'show_all_extensions',
		'description' =>	'Show all filename extensions in Finder',
		'key' => 			' NSGlobalDomain AppleShowAllExtensions',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'finder_search_scope',
		'description' =>	'Use current directory as default search scope in Finder',
		'key' => 			'com.apple.finder FXDefaultSearchScope',
		'type' => 			'string',
		'value' => 			'"SCcf"'
	},
	{
		'name' => 			'finder_show_pathbar',
		'description' =>	'Show Path bar in Finder',
		'key' => 			'com.apple.finder ShowPathbar',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'finder_show_statusbar',
		'description' =>	'Show Status bar in Finder',
		'key' => 			'com.apple.finder ShowStatusBar',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'expand_save_panel',
		'description' =>	'Expand save panel by default',
		'key' => 			'NSGlobalDomain NSNavPanelExpandedStateForSaveMode',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'expand_print_panel',
		'description' =>	'Expand print panel by default',
		'key' => 			'NSGlobalDomain PMPrintingExpandedStateForPrint',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_open_dialog',
		'description' =>	'Disable the “Are you sure you want to open this application?” dialog',
		'key' => 			'com.apple.LaunchServices LSQuarantine',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'disable_screenshot_shadows',
		'description' =>	'Disable shadow in screenshots',
		'key' => 			'com.apple.screencapture disable-shadow',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'highlight_grid_view_hover',
		'description' =>	'Enable highlight hover effect for the grid view of a stack (Dock)',
		'key' => 			'com.apple.dock mouse-over-hilte-stack', 
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'enable_spring_loading',
		'description' =>	'Enable spring loading for all Dock items',
		'key' => 			'enable-spring-load-actions-on-all-items',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_open_hightlights',
		'description' =>	'Hide indicator lights for open applications in the Dock',
		'key' => 			'com.apple.dock show-process-indicators',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'display_ascii_control_characters',
		'description' =>	'Display ASCII control characters using caret notation in standard text views',
		'key' => 			'NSGlobalDomain NSTextShowsControlCharacters',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'enable_airdrop_always',
		'description' =>	'Enable AirDrop over Ethernet and on unsupported Macs running Lion',
		'key' => 			'com.apple.NetworkBrowser BrowseAllInterfaces',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_disk_verification_1',
		'description' =>	'Disable disk image verification (1/3)',
		'key' => 			'com.apple.frameworks.diskimages skip-verify',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_disk_verification_2',
		'description' =>	'Disable disk image verification (2/3)',
		'key' => 			'com.apple.frameworks.diskimages skip-verify-locked',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_disk_verification_3',
		'description' =>	'Disable disk image verification (3/3)',
		'key' => 			'com.apple.frameworks.diskimages skip-verify-remote',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'open_finder_on_mount_1',
		'description' =>	'Automatically open a new Finder window when a volume is mounted (1/3)',
		'key' => 			'com.apple.frameworks.diskimages auto-open-ro-root',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'open_finder_on_mount_2',
		'description' =>	'Automatically open a new Finder window when a volume is mounted (2/3)',
		'key' => 			'com.apple.frameworks.diskimages auto-open-rw-root',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'open_finder_on_mount_3',
		'description' =>	'Automatically open a new Finder window when a volume is mounted (3/3)',
		'key' => 			'com.apple.finder OpenWindowForNewRemovableDisk',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'finder_title_full_path',
		'description' =>	'Display full POSIX path as Finder window title',
		'key' => 			'com.apple.finder _FXShowPosixPathInTitle',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'increase_window_resize_speec',
		'description' =>	'Increase window resize speed for Cocoa applications',
		'key' => 			'NSGlobalDomain NSWindowResizeTime',
		'type' => 			'float',
		'value' => 			'0.001'
	},
	{
		'name' => 			'no_ds_store_on_network',
		'description' =>	'Avoid creating .DS_Store files on network volumes',
		'key' => 			'com.apple.desktopservices DSDontWriteNetworkStores',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_extension_warning',
		'description' =>	'Disable the warning when changing a file extension',
		'key' => 			'com.apple.finder FXEnableExtensionChangeWarning',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'disable_trash_warning',
		'description' =>	'Disable the warning before emptying the Trash',
		'key' => 			'com.apple.finder WarnOnEmptyTrash',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'tap_to_click',
		'description' =>	'Enable tap to click (Trackpad)',
		'key' => 			'com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_safari_thumbnail_cache',
		'description' =>	'Disable Safari’s thumbnail cache for History and Top Sites',
		'key' => 			'com.apple.Safari DebugSnapshotsUpdatePolicy',
		'type' => 			'int',
		'value' => 			'2'
	},
	{
		'name' => 			'enable_safari_debug',
		'description' =>	'Enable Safari’s debug menu',
		'key' => 			'com.apple.Safari IncludeInternalDebugMenu',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'safari_search_contains',
		'description' =>	'Make Safari’s search banners default to Contains instead of Starts With',
		'key' => 			'com.apple.Safari FindOnPageMatchesWordStartsOnly',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'safari_web_inspector_context_menu',
		'description' =>	'Add a context menu item for showing the Web Inspector in web views',
		'key' => 			'NSGlobalDomain WebKitDeveloperExtras',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'terminal_utf8',
		'description' =>	'Only use UTF-8 in Terminal.app',
		'key' => 			'com.apple.terminal StringEncodings',
		'type' => 			'array',
		'value' => 			'4'
	},
	{
		'name' => 			'disable_itunes_ping',
		'description' =>	'Disable the Ping sidebar in iTunes',
		'key' => 			'com.apple.iTunes disablePingSidebar',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'disable_itunes_ping_misc',
		'description' =>	'Disable all the other Ping stuff in iTunes',
		'key' => 			'com.apple.iTunes disablePing',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'itunes_cmd_f_search',
		'description' =>	'Make ⌘ + F focus the search input in iTunes',
		'key' => 			'com.apple.iTunes NSUserKeyEquivalents',
		'type' => 			'dict-add',
		'value' => 			'"Target Search Field" "@F"'
	},
	{
		'name' => 			'show_library_folder',
		'description' =>	'Show the ~/Library folder',
		'command' => 		'chflags nohidden ~/Library'
	},
	{
		'name' => 			'disable_local_time_machine',
		'description' =>	'Disable local Time Machine backups',
		'command' => 		'hash tmutil &> /dev/null && sudo tmutil disablelocal'
	},
	{
		'name' => 			'ql_text_selection',
		'description' =>	'Allow text selection in Quick Look',
		'key' => 			'com.apple.finder QLEnableTextSelection',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'empty_trash_securely',
		'description' =>	'Empty Trash securely by default',
		'key' => 			'com.apple.finder EmptyTrashSecurely',
		'type' => 			'bool',
		'value' => 			'true'
	},
	{
		'name' => 			'enable_ffm_terminal',
		'description' =>	'Enable “focus follows mouse” for Terminal.app',
		'key' => 			'com.apple.terminal FocusFollowsMouse',
		'type' => 			'bool',
		'value' => 			'false'
	},
	{
		'name' => 			'enable_ffm_x11',
		'description' =>	'Enable “focus follows mouse” in all X11 apps',
		'key' => 			'org.x.X11 wm_ffm',
		'type' => 			'bool',
		'value' => 			'false'
	}
]

commands.each do |config|
	bash "osx_configuration_#{config['name']}" do
		if config['command']
			code config['command']
		else
			code "defaults write #{config['key']} -#{config['type']} #{config['value']}"

			not_if do
				value = %x[defaults read #{config['key']}].to_s.strip
				( config['value'] == 'true' && value == '1' ) ||
				( config['value'] == 'false' && value == '0' ) ||
				( config['value'] == value )
			end
		end
	end
end
