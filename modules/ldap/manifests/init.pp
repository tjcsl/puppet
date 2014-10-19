class ldap {
    package { 'openldap':
        ensure => latest,
        require => Class[aur]
    }
    file { '/etc/ldap.conf':
        source => 'puppet:///modules/ldap/ldap.conf'
        require => Package[openldap]
    }
}
