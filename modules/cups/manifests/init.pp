class cups {
    package { 'cups':
        ensure => latest
    }
    file { '/etc/cups/client.conf':
        ensure => present,
        source => 'puppet:///modules/cups/client.conf',
        notify => Service[cups]
    }
    service { 'cups':
        ensure => running,
        enable => true,
        require => Package[cups]
    }
}
