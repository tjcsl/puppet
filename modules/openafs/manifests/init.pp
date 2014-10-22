class openafs {
    package { 'openafs-modules-dkms':
        ensure  => present,
        require => [Class[aur],Package[dkms]]
    }
    package { 'openafs':
        ensure  => present,
        require => Package[openafs-modules-dkms]
    }
    file { '/etc/openafs/cacheinfo':
        ensure => present,
        require => Package[openafs],
        source => 'puppet:///modules/openafs/cacheinfo'
    }
    file { '/etc/openafs/ThisCell':
        ensure => present,
        require => Package[openafs],
        source => 'puppet:///modules/openafs/ThisCell'
    }
    file { '/etc/openafs/CellServDB':
        ensure => present,
        require => Package[openafs],
        source => 'puppet:///modules/openafs/CellServDB'
    }
    service { 'openafs-client':
        ensure => running,
        enable => true,
        require => Package[openafs],
        subscribe => [File['/etc/openafs/CellServDB'],File['/etc/openafs/ThisCell'],File['/etc/openafs/cacheinfo']]
    }
}
