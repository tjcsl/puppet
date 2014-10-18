class xserver {
    # Driver
    exec { 'nvidia-dkms':
        command => '/usr/bin/yes | /usr/bin/yaourt --noprogressbar --needed -Sy nvidia-dkms',
    }

    # Update module on kernel update
    package {'nvidia-hook':
        ensure  => latest
    }

    # Xorg server
    package { ['xorg-server','xorg-server-utils','xorg-apps']:
        ensure          => latest,
        require         => Exec[nvidia-dkms],
        install_options => '--needed'
    }
    # Window managers
    package { ['xfce4','gnome','kde','kdeutils','i3-wm','awesome','wmii','dwm','xorg-twm','icewm','fluxbox','lxde','metacity']:
        ensure  => latest,
        require => Class[aur],
        install_options => '--needed'
    }
    # GDM
    package { 'gdm':
        ensure  => latest,
    }
    # Start gdm
    service { 'gdm':
        ensure    => running,
        require   => Package[gdm],
        subscribe => Package[gdm],
    }
    exec { 'reboot machine':
        command     => '/sbin/reboot',
        subscribe   => Exec[nvidia-dkms],
        unless      => '/usr/bin/lsmod | /usr/bin/grep ^nvidia',
        refreshonly => true,
    }
}
