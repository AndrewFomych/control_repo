node default{
  file {'/root/README':
    ensure  => file,
    content => 'This is readme file',
    owner   => 'root',
  }
  
  file {'/root/README':
    owner   => 'root',
  }
}
