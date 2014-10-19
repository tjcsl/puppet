class nsswitch {
    package { 'nss_ldap':
        ensure => latest,
        require => Class[aur]
    }
    file { '/etc/nsswitch.conf':
        ensure => file,
        source => 'puppet:///modules/nsswitch/nsswitch.conf'
    }

}
