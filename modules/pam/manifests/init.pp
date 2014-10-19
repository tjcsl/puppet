class pam {
    package { ['pam_krb5','pam-afs-session']:
        ensure => latest,
        require => Class[aur]
    }
    file { '/etc/pam.d/system-auth':
        ensure => file,
        source => 'puppet:///modules/pam/system-auth'
    }

}
