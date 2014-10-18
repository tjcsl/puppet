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
    package { ['screen','puppet','tmux']:
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
