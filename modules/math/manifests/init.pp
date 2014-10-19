class math {
    file { '/opt/Mathematica_10.0.1_LINUX.sh':
        ensure => file,
        source => 'puppet:///modules/math/Mathematica_10.0.1_LINUX.sh',
        mode => 755
    }
    file { '/tmp/yaourt-tmp-root/aur-mathematica/':
        ensure => directory,
        require => Class[aur]
    }
    file { '/tmp/yaourt-tmp-root/aur-mathematica/Mathematica_10.0.1_LINUX.sh':
        ensure => link,
        target => '/opt/Mathematica_10.0.1_LINUX.sh',
        require => [File['/tmp/yaourt-tmp-root/aur-mathematica/'],File['/opt/Mathematica_10.0.1_LINUX.sh']]
    }
    file { '/opt/mathematica/Configuration/Licensing/mathpass':
        ensure => file,
        source => 'puppet:///modules/math/mathpass',
        require => Exec[mathematica]
    }
    exec { 'mathematica':
        path => '/usr/bin/:/bin/',
        command => "sh -c 'cd /tmp/yaourt-tmp-root/;wget https://aur.archlinux.org/packages/ma/mathematica/mathematica.tar.gz;tar -xf mathematica.tar.gz -C aur-mathematica;mv aur-mathematica/mathematica/* aur-mathematica/;rm mathematica.tar.gz*;cd aur-mathematica;makepkg -csir --asroot;cd ..'",
        unless => 'which math',
        timeout => 0,
        require => [File['/tmp/yaourt-tmp-root/aur-mathematica/Mathematica_10.0.1_LINUX.sh'],Class[aur]]
    }

}
