class editors {

  # vim
    # => https://github.com/adamhjk/adam-vim
    # => http://gyaresu.org/hacking/2012/07/28/remap-space-bar-to-remove-search-highlighting-in-vim/
    # => https://github.com/amix/vimrc
    # => http://amix.dk/vim/vimrc.html
    # => http://yanpritzker.com/2012/05/30/stop-using-colon-commands-in-vim/
  # powerline
    # => https://gist.github.com/1595572
  # vim-rails
  # sublime
  # vundle
    # => https://github.com/gmarik/vundle/issues/182
    # => https://github.com/gmarik/vundle/wiki/Examples

  exec { 'macvim':
    command   => 'brew install --override-system-vim --with-cscope --with-lua \
                  https://raw.github.com/JeanMertz/dotfiles/next/formula/macvim.rb',
    creates   => '/usr/local/Cellar/macvim/',
    user      => $user,
  }

  package { 'gem-ctags':
    provider  => gem,
    require   => Package['ctags'],
  }

  package { 'gem-browse':
    provider  => gem,
  }

  exec { 'gem ctags':
    path      => '/Users/${user}/.rbenv/shims/',
    requires  => Package['gem-ctags'],
    user      => $user,
  }

  package { 'vimpager': }

}
