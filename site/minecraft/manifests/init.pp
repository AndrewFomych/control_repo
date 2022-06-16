class minecraft{
  file{'/opt/minecraft':
    ensure => directory,
  }
  
  include java
  java::download { 'jdk17':
    ensure  => 'present',
    java_se => 'jdk',
    url     => 'https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm',
  }
  
  file{'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar'
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
