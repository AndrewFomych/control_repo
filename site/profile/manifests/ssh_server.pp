class profile::ssh_server{
  package {'openssh-server':
    ensure => present,
  }
  
  service {'sshd':
    ensure => 'running',
    enable => 'true',
  }
  
  ssh_authorized_key { 'root@master.puppet.vm':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDhDn5tgS3KQLZ2TRnB2gdARh2tugigDmk1mPwmrnCPcr0Gf2yShM763M8L2LAOVNph3QD8xHTqWubnqsEQKlP/tyKPcyvdaQ+z27OQ5qy8OhWw1e6TLZiltHjolX05mElr81EVbRFOwP/MtlYNHi4j2JqlCsosGwbn/2jCCS3BgkOBd/U1vXbVGZqCtlr/NIEb/CsQdB2XfpRwGkravzTW6XDxkqUZ+1OikWAsuQrmValmB2IJkgeDaHuTKUl+kZXAjCDOL7fyPPfNRMVX83KVuWG1BrueU+25rhDQzaMjHUrEU98qaHhz83Kxg38JM57d40AqjaiPVU7WH7EiWuUj',
  }
}
