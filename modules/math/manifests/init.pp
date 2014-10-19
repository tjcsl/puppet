class math {
    file { '/opt/Mathematica_10.0.1_LINUX.sh':
        ensure => file,
        source => 'puppet:///modules/math/Mathematica_10.0.1_LINUX.sh'
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
        command => 'cd /tmp/yaourt-tmp-root/aur-mathematica/;wget https://aur.archlinux.org/packages/ma/mathematica/mathematica.tar.gz;tar -xf mathematica.tar.gz mathematica/;makepkg -csir;cd ..;rm -rf aur-mathematica;',
        unless => 'which math',
        require => [File['/tmp/yaourt-tmp-root/aur-mathematica/Mathematica_10.0.1_LINUX.sh'],Class[aur]]
    }

}
