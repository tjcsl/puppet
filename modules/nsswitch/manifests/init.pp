class nsswitch {
    file { '/etc/nsswitch.conf':
        ensure => file,
        source => 'puppet:///modules/nsswitch/nsswitch.conf'
    }

}
