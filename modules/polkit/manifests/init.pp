class polkit {
    service { 'polkit':
        ensure => running,
        enable => true,
        require => Class[aur]
    }
    file { '/etc/polkit-1/rules.d/10-disable-poweroff.rules':
        ensure => file,
        mode => 644,
        source => 'puppet:///modules/polkit/disable-poweroff',
        notify => Service[polkit]
    }

}
