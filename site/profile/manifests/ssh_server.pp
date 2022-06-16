class profile::ssh_server {
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
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDjUVpwaqEBKM+uGpWmKrcVugDjfm8lIzdekvW5Di6zd+AVdpwiC6TnkzqPYOOXdduFao9fp3rxenwx71VHQiYqVfjdqTvoIPZJj4WuV6DONqsN3hRh7OlMbvysOpkCp2LIa66F0FLL9EqXELUnuDlCzYPyAOPGVTKf+Ol555G6ThP4GIcq45xSRt1arUgfK5o7ybq/S2fFlLzLdn6q5RJwBxVsaVPK51Wipw0Kkz3P0bSYHxugUVnsKdOY0UJVhV/06cnMzcAwujollOFI25IHqX9nBIEWZ9s4lf8Z8mk72TvKUTpq+kdy6K1V928lu9VUjgAh9igNNtCrrLgquYlr',
  }
}
