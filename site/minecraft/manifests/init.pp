class minecraft{
  file{'/opt/minecraft':
    ensure => directory,
  }
  
  file{'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar'
  }
  
  include java
  
  java::adoptium { 'jdk17':
    ensure  => 'present',
    version_major => '17',
    version_minor => '0',
    version_patch => '3',
    version_build => '1',
  }
  
  file{'/opt/minecraft/eula.txt':
    ensure => true,
    content => 'eula=true',
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
}
