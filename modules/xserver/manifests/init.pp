class xserver {
    # Driver
    exec { 'nvidia-dkms':
        command => '/usr/bin/yes | /usr/bin/yaourt --noprogressbar --needed -Sy nvidia-dkms && modprobe nvidia',
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
    package { ['xfce4','gnome','kde','kdeutils','i3-wm','i3lock','awesome','wmii','dwm','xorg-twm','icewm','fluxbox','lxde','metacity','xmonad','xmobar-git','xmonad-contrib','xscreensaver-arch-logo','evilwm','herbstluftwm','ratpoison','spectrwm','wmfs']:
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
