node default {

  Package { ensure => latest }
  Vcsrepo { ensure => latest, provider => git }


}
