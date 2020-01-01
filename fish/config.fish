# Set language configuration
set -gx LC_ALL en_GB.UTF-8

# Set the corect color codes for gruvbox.
bash "$HOME/.config/fish/gruvbox_256palette.sh"

# Remove all universal variables.
for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    if test "$v" = "history" || test "$v" = "fish_key_bindings"
        continue
    end

    set -e $v
end

# See: https://fishshell.com/docs/current/index.html#variables-color
#
# Named colors (such as "yellow") will be set to "gruvbox" colors using
# `gruvbox_256palette.sh` (see above).
#
# The pound-color codes serve no purpose other than making the Vim color code
# highlight plugin show what colr is used.
set fish_color_normal               ebdbb2 #ebdbb2
set fish_color_command              bryellow #fadb2f
set fish_color_quote                green #98971a
set fish_color_redirection          red #cc241d
set fish_color_end                  red #cc241d
set fish_color_error                red #cc241d
set fish_color_param                ebdbb2 #ebdbb2
set fish_color_comment              a89984 #a89984
set fish_color_match                --background=orange
set fish_color_selection            white --bold --background=brblack
set fish_color_search_match         bryellow --background=brblack
set fish_color_operator             magenta
set fish_color_escape               aqua
set fish_color_cwd                  green
set fish_color_autosuggestion       grey
set fish_color_user                 brgreen #green
set fish_color_host                 normal
set fish_color_cancel               --reverse

set fish_pager_color_prefix         fff --bold --underline #fff
set fish_pager_color_completion
set fish_pager_color_description    b3a06d #b3a06d
set fish_pager_color_progress       brwhite --background=cyan
set fish_pager_color_secondary      brgreen --background=magenta

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
# see: https://www.gnupg.org/documentation/manuals/gnupg/Common-Problems.html
set -gx GPG_TTY (tty)
