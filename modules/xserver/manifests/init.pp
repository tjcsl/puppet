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
    package { ['xfce4','gnome','kde','kdeutils','i3-wm','i3lock','awesome','dwm','icewm','fluxbox','lxde','xmonad','xmobar-git','xmonad-contrib','xscreensaver-arch-logo','evilwm','herbstluftwm','ratpoison','spectrwm','wmfs']:
        ensure  => latest,
        require => Class[aur],
        install_options => '--needed'
    }
    # X utilities
    package { ['xorg-xclock','xorg-xeyes','x11vnc','xsnow','xdotool','rxvt-unicode']:
        ensure => latest,
        require => [Package[xorg-server],Class[aur]]
    }
    # lightdm
    package { 'lightdm':
        ensure  => latest,
    }
    # Start lightdm
    service { 'lightdm':
        ensure    => running,
        enable => true,
        require   => Package[lightdm],
        subscribe => Package[lightdm],
    }
    exec { 'reboot machine':
        command     => '/sbin/reboot',
        subscribe   => Exec[nvidia-dkms],
        unless      => '/usr/bin/lsmod | /usr/bin/grep ^nvidia',
        refreshonly => true,
    }
}
