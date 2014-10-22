class ldap {
    package { 'openldap':
        ensure => latest,
        require => Class[aur]
    }
    package { 'nss-pam-ldapd':
        ensure => latest,
        require => Class[aur]
    }
    file { '/etc/ldap.conf':
        source => 'puppet:///modules/ldap/ldap.conf',
        require => Package[openldap]
    }
    file { '/etc/nslcd.conf':
        source => 'puppet:///modules/ldap/nslcd.conf',
        require => Package[nss-pam-ldapd],
        notify => Service[nslcd]
    }
    service { 'nslcd':
        ensure => running,
        enable => true,
        require => Package[nss-pam-ldapd]
    }
}
