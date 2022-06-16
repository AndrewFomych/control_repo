class minecraft{
  file{'/opt/minecraft':
    ensure => directory,
  }
  
  file{'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar'
  }
  
  package{'java':
    ensure => present,
  }
  
  file{'/opt/minecraft/eula.txt':
    ensure => true,
    content => 'eula=true',
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
}
