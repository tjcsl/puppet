node default {
    include aur
    include xserver
    include cups
    include openafs
    include pam
    include ldap
    include nsswitch
    include polkit
    include math
    class { '::ntp':
          servers => [ 'ntp1.tjhsst.edu', 'ntp2.tjhsst.edu' ],
    }
    class { 'mit_krb5':
        default_realm => 'CSL.TJHSST.EDU',
        allow_weak_crypto => true
    }
    class { 'ssh':
        server_options => {
            'ChallengeResponseAuthentication' => 'yes',
            'GSSAPIAuthentication' => 'yes',
            'GSSAPICleanupCredentials' => 'yes',
            'Banner' => '/etc/issue',
            'UsePAM' => 'yes', 
            'PasswordAuthentication' => 'no'
        }
    }
    mit_krb5::realm { 'CSL.TJHSST.EDU':
        kdc => ['kdc1.tjhsst.edu','kdc2.tjhsst.edu'],
        admin_server => 'kerberos.tjhsst.edu',
        auth_to_local => ['RULE:[1:$1@$0](^.*@LOCAL\.TJHSST\.EDU$)s/@.*$//','DEFAULT']
    }
    mit_krb5::realm { 'LOCAL.TJHSST.EDU':
        kdc => ['198.38.27.6','tj05.local.tjhsst.edu','tj07.local.tjhsst.edu'],
        admin_server => 'tj07.local.tjhsst.edu'
    }
    mit_krb5::domain_realm { 'CSL.TJHSST.EDU':
        domains => ['.tjhsst.edu','tjhsst.edu','.csl.tjhsst.edu','csl.tjhsst.edu']
    }
    mit_krb5::domain_realm { 'LOCAL.TJHSST.EDU':
        domains => ['local.tjhsst.edu','.local.tjhsst.edu']
    }
    package { 'linux-headers':
        ensure => installed
    }
    package { 'dkms':
        ensure  => latest,
        require => Package[linux-headers]
    }
    service { 'dkms':
        ensure => running,
        enable => true,
        require => Package[dkms]
    }
    # Browsers
    package { ['google-chrome','firefox','opera','links'/*,'internet-explorer'*/]:
        ensure => latest,
        require => Class[aur]
    }
    # Editors
    package { ['vim','emacs','ed','hexedit','nano','sublime-text','kdesdk-kate',
        'vim-plugins','vim-python','pycharm-community','jgrasp','netbeans','eclipse',
        'android-studio','geany','appinventor','bless']:
        ensure => latest,
        require => Class[aur],
        install_options => '--needed'
    }
    # Python Packages
    package { ['python-beautifulsoup4','python2-beautifulsoup4','python-dnspython',
        'python2-dnspython','python-pymysql','python2-pymysql','python2-pygame','pypy',
        'pypy3','python-virtualenv','python2-virtualenv','python-sqlalchemy',
        'python2-sqlalchemy','python2-ldap','python-scipy','python2-scipy']:
        ensure => latest,
        require => Class[aur]
    }
    # Shells
    package { ['bash','zsh','oh-my-zsh-git','fish']:
        ensure => latest,
        require => Class[aur]
    }
    # IRC / IM
    package { ['weechat','irssi','hexchat','mcabber','pidgin','pork']:
        ensure => latest,
        require => Class[aur]
    }
    # Games
    package { ['love','bzflag','nexuiz','quake3','sauerbraten','xonotic','cowsay','doge','minecraft']:
        ensure => latest,
        require => Class[aur]
    }
    # Libraries
    package { ['sdl2','libvorbis','opencv','sdl2_mixer','opusfile']:
        ensure => latest,
        require => Class[aur]
    }
    # VCS
    package { ['git','cvs','mercurial','subversion']:
        ensure => latest,
        require => Class[aur]
    }
    # Archiving system
    package { ['libzip','p7zip','tar']:
        ensure => latest,
        require => Class[aur]
    }
    # Mail
    package { ['thunderbird','mailx','cone']:
        ensure => latest,
        require => Class[aur]
    }
    # Ruby
    package { ['ruby','ruby-rails']:
        ensure => latest,
        require => Class[aur]
    }
    # Other Languages
    package { ['go','php','scala','nodejs']:
        ensure => latest,
        require => Class[aur]
    }
    # Networking
    package { ['gnu-netcat','dnsutils','wireshark-cli','wireshark-gtk','openmpi','traceroute',
        'iftop','iputils','jnettop','nmap','ethtool']:
        ensure => latest,
        require => Class[aur]
    }
    # Connecting / transfer protocols / protocol specific
    package { ['filezilla','lftp','mosh','clusterssh','rdesktop','sshpass','wgetpaste','tightvnc']:
        ensure => latest,
        require => Class[aur]
    }
    # Sound
    package { ['beep','alsa-utils','gnome-alsamixer','pulseaudio','gpac','mplayer','espeak','audacity']:
        ensure => latest,
        require => Class[aur]
    }
    # Image / Video
    package { ['vlc','imagemagick','steghide','graphviz','inkscape','jp2a','librecad']:
        ensure => latest,
        require => Class[aur]
    }   
    # Misc Utilities
    package { ['screen','puppet','tmux','flashplugin','oraclejdk7-64','oraclejdk8-64','acroread',
        'toilet','winetricks','binwalk','figlet','sl','mono','skipfish','strace','valgrind',
        'htop','acpid']:
        ensure  => latest,
        require => Class[aur]
    }
    service { 'acpid':
        ensure => running,
        enable => true,
        subscribe => Package[acpid]
    }
}
