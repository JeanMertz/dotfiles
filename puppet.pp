node default {

  $user = 'Jean'
  Package { ensure => latest, provider => brew }
  Vcsrepo { ensure => latest, provider => git }

  include terminal      # fishfish, man pages, tmux, powerline, etc...
  include dependencies  # required packages, like curl, etc...

}
