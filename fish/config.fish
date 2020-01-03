# Set language configuration
set -gx LC_ALL en_GB.UTF-8

# Remove Fish greeting message
set fish_greeting

# Set the corect color codes for gruvbox.
bash "$HOME/.config/fish/gruvbox_256palette.sh"

# Remove all universal variables.
for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    if test "$v" = "history" || test "$v" = "fish_key_bindings"
        continue
    end

    set -e $v
end

# Kitty completion
kitty + complete setup fish | source

# Abbreviations
if status --is-interactive
  abbr --add --global vim nvim

  # Git
  abbr --add --global gs git status
  abbr --add --global gpu git push
  abbr --add --global gp git pull
  abbr --add --global ga git add .
  abbr --add --global gap git add -p
  abbr --add --global gco git checkout
  abbr --add --global gd git diff
  abbr --add --global gdc git diff --cached
end

# Window title logic (runs before and after every command)
function fish_title
  if test "$_" = "fish"
    if test "$PWD" = "$HOME"
      echo "~"
    else
      basename "$PWD"
    end
  else
    echo (basename "$PWD"): (status current-command)
  end
end

# Prompt prefix logic (runs before every new prompt line)
function fish_prompt --description 'Write out the prompt'
  printf '%s%s%s %%%s ' (set_color "$fish_color_cwd" --bold) (prompt_pwd) (set_color green --bold) (set_color normal)
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
set fish_color_cwd                  cyan #689d6a
set fish_color_autosuggestion       grey
set fish_color_user                 brgreen #b8bb26
set fish_color_host                 normal
set fish_color_cancel               --reverse

set fish_pager_color_prefix         fff --bold --underline #fff
set fish_pager_color_completion
set fish_pager_color_description    b3a06d #b3a06d
set fish_pager_color_progress       brwhite --background=cyan
set fish_pager_color_secondary      brgreen --background=magenta

# commonly used folders
set -gx XDG_CACHE_HOME  "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME   "$HOME/.local/share"
set -gx XDG_RUNTIME_DIR "$TMPDIR/.run"

set -gx CARGO_HOME            "$XDG_CONFIG_HOME/rust/cargo"
set -gx GNUPGHOME             "$XDG_CONFIG_HOME/gpg"
set -gx MYVIMRC               "$XDG_CONFIG_HOME/nvim/init.vim"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx GOPATH                "$XDG_DATA_HOME/go"

# Colored man pages
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

# FZF configuration
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git \$dir'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Disable Homebrew Analytics
set -gx HOMEBREW_NO_ANALYTICS 1

# Add required PATH variable values
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths # Homebrew
set -g fish_user_paths "$CARGO_HOME/bin" $fish_user_paths # Cargo
set -g fish_user_paths (npm -g bin) $fish_user_paths      # NPM

# GPG config
# see: https://www.gnupg.org/documentation/manuals/gnupg/Common-Problems.html
set -gx GPG_TTY (tty)
