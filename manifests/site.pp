node default {
    include ssh
    include aur
    include xserver
    class { '::ntp':
          servers => [ 'ntp1.tjhsst.edu', 'ntp2.tjhsst.edu' ],
    }
    package { 'linux-headers':
        ensure => installed
    }
    package { 'dkms':
        ensure  => latest,
        require => Package[linux-headers]
    }
    # Browsers
    package { ['google-chrome','firefox','opera'/*,'internet-explorer'*/]:
        ensure => latest,
        require => Class[aur]
    }
    # Editors
    package { ['vim','sublime-text','kdesdk-kate','vim-plugins','vim-python']:
        ensure => latest,
        require => Class[aur],
        install_options => '--needed'
    }
    # Shells
    package { ['bash','zsh','oh-my-zsh-git','fish']:
        ensure => latest,
        require => Class[aur]
    }
    # IRC
    package { ['weechat','irssi','hexchat']:
        ensure => latest,
        require => Class[aur]
    }
    # Utilities
    package { ['screen','puppet','tmux','minecraft','wgetpaste','imagemagick','thunderbird','gnu-netcat','dnsutils','libzip','p7zip','tar']:
        ensure  => latest,
        require => Class[aur]
    }
    package { 'openafs-modules-dkms':
        ensure  => present,
        require => Class[aur]
    }
    package { 'openafs':
        ensure  => present,
        require => Package[openafs-modules-dkms]
    }

}
