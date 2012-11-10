class dependencies {
  # curl
  # bash

  package { 'curl': }
  package { 'bash': }
  package { 'ack': }
  package { 'ctags': }

  package { 'ruby-debug-ide':
    provider  => gem,
  }
}
