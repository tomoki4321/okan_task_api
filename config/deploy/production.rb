server '43.207.26.25', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/user/.ssh/id_rsa'