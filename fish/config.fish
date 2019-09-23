# Set language configuration
set -gx LC_ALL en_GB.UTF-8

# Remove all universal variables.
for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    set -e $v
end

# commonly used folders
set -gx XDG_CACHE_HOME  "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME   "$HOME/.local/share"

# Disable Homebrew Analytics
set -gx HOMEBREW_NO_ANALYTICS 1
