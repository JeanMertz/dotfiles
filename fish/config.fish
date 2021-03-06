# temporary workaround. See: https://apple.stackexchange.com/a/375629/10897
function apropos --wraps apropos --description 'workaround apropos Catalina bug'
    rm -i $argv
    ~/.local/share/workarounds/apropos.macos_10.15.1 $argv
end

# Set language configuration
set -gx LC_ALL en_GB.UTF-8

# Remove Fish greeting message
set fish_greeting

# Set the corect color codes for gruvbox.
bash "$HOME/.config/fish/gruvbox_256palette.sh"

# Remove all universal variables.
for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    if test "$v" = "history" \
       || test "$v" = "fish_key_bindings" \
       || test "$v" = "__fish_initialized" \
       || test "$v" = "PWD" \
       || test "$v" = "pipestatus" \
       || test "$v" = "status"
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
  abbr --add --global gpf git push --force-with-lease
  abbr --add --global gp git pull
  abbr --add --global ga git add .
  abbr --add --global gap git add -p
  abbr --add --global gco git checkout
  abbr --add --global gcob git checkout -b jean/
  abbr --add --global gd git diff
  abbr --add --global gdc git diff --cached
  abbr --add --global gss git stash push --include-untracked
  abbr --add --global gsp git stash pop
  abbr --add --global gb git branch
  abbr --add --global grs git restore --staged
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
set -gx DOTFILES  "$HOME/dotfiles"
set -gx XDG_CACHE_HOME  "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME   "$HOME/.local/share"
set -gx XDG_RUNTIME_DIR "$TMPDIR/.run"

set -gx CARGO_HOME            "$XDG_DATA_HOME/rust/cargo"
set -gx GNUPGHOME             "$XDG_CONFIG_HOME/gpg"
set -gx MYVIMRC               "$XDG_CONFIG_HOME/nvim/init.vim"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx GOPATH                "$XDG_DATA_HOME/go"
set -gx RUSTUP_HOME           "$XDG_DATA_HOME/rust/rustup"

# Colored man pages
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

# AWS CLI XDG
set -x AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -x AWS_CLI_HISTORY_FILE "$XDG_DATA_HOME/aws/history"
set -x AWS_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -x AWS_WEB_IDENTITY_TOKEN_FILE "$XDG_CONFIG_HOME/aws/token"
set -x AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/shared-credentials"

# Default editor
set -x VISUAL nvim
set -x EDITOR nvim

# FZF configuration
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git \$dir'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# LESS configuration
set -x LESS '--RAW-CONTROL-CHARS --tilde --chop-long-lines --ignore-case --tabs=4'

# Disable Homebrew Analytics
set -gx HOMEBREW_NO_ANALYTICS 1

# Add required PATH variable values
set -g fish_user_paths
set -g fish_user_paths (npm config get prefix)/bin $fish_user_paths # NPM
set -g fish_user_paths (go env GOPATH) $fish_user_paths             # Go
set -g fish_user_paths "$CARGO_HOME/bin" $fish_user_paths           # Cargo
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths           # Homebrew

# GPG config
# see: https://www.gnupg.org/documentation/manuals/gnupg/Common-Problems.html
set -gx GPG_TTY (tty)

# Install "Fisher" plugins to XDG_DATA_HOME
set -g fisher_path "$XDG_DATA_HOME/fisher"

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end
