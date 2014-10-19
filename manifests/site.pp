node default {
    include ssh
    include aur
    include xserver
    include cups
    class { '::ntp':
          servers => [ 'ntp1.tjhsst.edu', 'ntp2.tjhsst.edu' ],
    }
    package { 'linux-headers':
        ensure => installed
    }
    package { 'dkms':
        ensure  => latest,
        require => Package[linux-headers]
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
    package { ['libsdl2','libvorbis','opencv','sdl2-mixer','opusfile']:
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
        'iftop','iputils','jnettop','nmap','tcptrack','wakeonlan','ethtool']:
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
        subscribe => Package[acpid]
    }
    package { 'openafs-modules-dkms':
        ensure  => present,
        require => Class[aur]
    }
    package { 'openafs':
        ensure  => present,
        require => Package[openafs-modules-dkms]
    }

}
