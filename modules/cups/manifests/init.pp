class cups {
    package { 'cups':
        ensure => latest
    }
    file { '/etc/cups/client.conf':
        ensure => present,
        source => 'puppet:///modules/cups/client.conf',
        notify => Service[cups]
    }
    service { 'cupsd':
        ensure => running,
        require => Package[cups]
    }
}
