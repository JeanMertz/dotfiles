class terminal {
  # fishfish (yay!!!!)
    # => http://ridiculousfish.com/shell/user_doc/html/design.html
    # => http://arstechnica.com/information-technology/2005/12/linux-20051218/2/
    # => https://github.com/fish-shell/fish-shell
    # => https://raw.github.com/DarkStarSword/junk/master/vi-mode.fish
    # => http://canadian-fury.com/2012/06/06/fish-shell/
    # => https://github.com/zmalltalker/fish-nuggets
  # tmux
    # => http://nils-blum-oeste.net/getting-started-with-tmux
    # => http://gyaresu.org/hacking/2012/07/03/tmux-and-vim-powerline/
    # => http://robots.thoughtbot.com/post/19398560514/how-to-copy-and-paste-with-tmux-on-mac-os-x (read comments)
  # powerline (tmux)
    # => https://gist.github.com/1595572
  # tmuxinator
    # => http://thedrearlight.com/blog/tmuxinator.html

  package { 'fishfish':
    install_options => { 'flags' => '--HEAD' }
  }

  file { '/etc/shells':
    content   => template("terminal/shells.erb"),
    owner     => 'root',
    group     => 'wheel',
    mode      => '0644',
    require   => Package['fishfish'],
  }

  package { 'tmux': }

  package { 'tmuxinator':
    provider  => gem,
    require   => Package['tmux']
  }

  vcsrepo { "/Users/${user}/.config/modules/tmux-powerline":
    source => 'https://github.com/erikw/tmux-powerline.git',
    require   => [Package['curl'], Package['bash']],
    user => $user
  }
}
