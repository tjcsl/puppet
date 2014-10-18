class packages {
    package { ['ssh','screen']: ensure => "latest" }
    package { ['nyancat']: ensure => "absent" }
}

