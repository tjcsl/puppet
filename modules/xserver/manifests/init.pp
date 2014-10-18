# == Class: xserver
#
# Full description of class xserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { xserver:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
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
    package { 'xfce4':
        ensure  => latest,
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
