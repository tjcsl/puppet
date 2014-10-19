class math {
    file { '/opt/Mathematica_10.0.1_LINUX.sh':
        ensure => file,
        source => 'puppet:///modules/math/Mathematica_10.0.1_LINUX.sh'
    }
    file { '/tmp/yaourt-tmp-root/aur-mathematica/src/':
        ensure => directory,
        require => Class[aur]
    }
    file { '/tmp/yaourt-tmp-root/aur-mathematica/src/Mathematica_10.0.1_LINUX.sh':
        ensure => link,
        target => '/opt/Mathematica_10.0.1_LINUX.sh',
        require => [File['/tmp/yaourt-tmp-root/aur-mathematica/src/'],File['/opt/Mathematica_10.0.1_LINUX.sh']]
    }
    file { '/opt/mathematica/Configuration/Licensing/mathpass':
        ensure => file,
        source => 'puppet:///modules/math/mathpass',
        require => Package[mathematica]
    }
    package { 'mathematica':
        ensure => installed,
        require => [File['/tmp/yaourt-tmp-root/aur-mathematica/src/Mathematica_10.0.1_LINUX.sh'],Class[aur]]
    }

}
