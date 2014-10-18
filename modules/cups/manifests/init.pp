class cups {
    package { 'cups':
        ensure => latest
    }
    file { '/etc/cups/client.conf':
        ensure => present,
        source => 'puppet:///modules/cups/client.conf',
        notify => Service[cupsd]
    }
    service { 'cupsd':
        ensure => running,
        require => Package[cups]
    }
}
