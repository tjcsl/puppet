class issue {
    file { '/etc/issue':
        content => template('issue/issue.erb')
    }
}

