# Set language configuration
set -gx LC_ALL en_GB.UTF-8

# Set the corect color codes for gruvbox.
bash "$HOME/.config/fish/gruvbox_256palette.sh"

# Remove all universal variables.
for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    set -e $v
end

# commonly used folders
set -gx GNUPGHOME       "$XDG_CONFIG_HOME/gpg"
set -gx XDG_CACHE_HOME  "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME   "$HOME/.local/share"

# Colored man pages
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

# Disable Homebrew Analytics
set -gx HOMEBREW_NO_ANALYTICS 1

# Set correct Homebrew paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# GPG config
set -gx GPG_TTY (tty)
