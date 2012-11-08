class terminal {
  # fishfish (yay!!!!)
    # => http://ridiculousfish.com/shell/user_doc/html/design.html
    # => http://arstechnica.com/information-technology/2005/12/linux-20051218/2/
    # => https://github.com/fish-shell/fish-shell
    # => https://raw.github.com/DarkStarSword/junk/master/vi-mode.fish
    # => http://canadian-fury.com/2012/06/06/fish-shell/
    # => https://github.com/zmalltalker/fish-nuggets

  package { 'fishfish':
    provider  => brew,
    install_options => { 'flags' => '--HEAD' }
  }

  file { '/etc/shells':
    content   => template("terminal/shells.erb"),
    owner     => 'root',
    group     => 'wheel',
    mode      => '0644',
    require   => Package['fishfish']
  }

  package { 'tmux':
    provider  => brew
  }
}
