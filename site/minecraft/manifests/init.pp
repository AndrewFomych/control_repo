class minecraft{
  file{'/opt/minecraft':
    ensure => directory,
  }
  
  file{'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar'
  }
  
  include java
  java::download { 'jdk17':
    ensure  => 'present',
    java_se => 'jdk',
    url     => 'openjdk-17.0.2_linux-x64_bin.tar.gz',
  }
  
  file{'/opt/minecraft/eula.txt':
    ensure  => file,
    content => 'eula=true',
  }
  
  file{'/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
  
  service{'minecraft':
    ensure => running,
    enable => true,
  }
}
