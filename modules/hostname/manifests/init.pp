class hostname {
    file { '/etc/conf.d/hostname':
        content => template('hostname/hostname.erb')
    }
}

