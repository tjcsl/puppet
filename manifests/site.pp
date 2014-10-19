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
    package { ['vim','emacs','ed','hexedit','nano','sublime-text','kdesdk-kate','vim-plugins','vim-python','pycharm-community','jgrasp','netbeans','eclipse','android-studio','geany','appinventor','texlive-most']:
        ensure => latest,
        require => Class[aur],
        install_options => '--needed'
    }
    # Python Packages
    package { ['python-beautifulsoup4','python2-beautifulsoup4','python-dnspython','python2-dnspython','python-pymysql','python2-pymysql','python-pygame','python2-pygame','pypy','pypy3','python-virtualenv','python2-virtualenv','python-sqlalchemy','python2-sqlalchemy','python2-ldap','python-scipy','python2-scipy']:
        ensure => latest,
        require => Class[aur]
    }
    # Shells
    package { ['bash','zsh','oh-my-zsh-git','fish']:
        ensure => latest,
        require => Class[aur]
    }
    # IRC
    package { ['weechat','irssi','hexchat']:
        ensure => latest,
        require => Class[aur]
    }
    # Games
    package { ['love','bzflag','nexuiz','quake3','sauerbraten','xonotic','cowsay','doge']:
        ensure => latest,
        require => Class[aur]
    }
    # Libraries
    package { ['libsdl2','libvorbis','nite','opencv','sdl2-mixer','opusfile']:
        ensure => latest,
        require => Class[aur]
    }
    # Utilities
    package { ['screen','puppet','tmux','minecraft','wgetpaste','imagemagick','thunderbird','gnu-netcat','dnsutils','libzip','p7zip','tar','mathematica','flashplugin','matlab','wireshark-cli','wireshark-gtk','openmpi','oraclejdk7-64','oraclejdk8-64','espeak','steghide','beep','acroread','toilet','winetricks','binwalk','bless','figlet','sl','espeak','go','php','ruby','mono','scala','ruby-rails','skipfish','strace','valgrind','git','cvs','mercurial','subversion','mailx','cone','gimp','graphviz','inkscape','jp2a','librecad','alsa-utils','audacity','gnome-alsamixer','pulseaudio','gpac','mplayer','vlc','arping','iftop','jnettop','nmap','tcptrack','filezilla','ftp','mcabber','pidgin','pork','nodejs','clusterssh','mosh','rdesktop','sshpass','tightvnc','wakeonlan','ethtool','htop','acpid','xclock','xeyes','x11vnc','xsnow','xdotool','deb2targz']:
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
