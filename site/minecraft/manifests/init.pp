class minecraft{
  file{'/opt/minecraft':
    ensure => directory,
  }
  
  /***Install Java***/
  /*include java
  java::download { 'jdk17':
    ensure  => 'present',
    java_se => 'jdk',
    url     => 'https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm',
  }*/
  /*package {'java':
    ensure => present,
  }*/
  file{'/jdk-17_linux-x64_bin.rpm':
    ensure => file,
    source => 'https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm',
  }
  exec{'jdk17':
    path => '~/',
    command => 'sudo rpm -ivh jdk-17_linux-x64_bin.rpm ; rm -f jdk-17_linux-x64_bin.rpm',
  }
  /*****************************/
  
  /***Install Minecraft Server***/
  file{'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar',
  }
  /*file {'/opt/minecraft/server.jar':
    ensure => file,
    source      => 'https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar',
  }*/
  /*****************************/
  
  /*** Needed file for the confirmation ***/
  file{'/opt/minecraft/eula.txt':
    ensure  => file,
    content => 'eula=true',
  }
  /*****************************/
  
  /*** File for autostart server ***/
  file{'/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
  /*****************************/
  
  /*** Enable autostart server ***/
  service{'minecraft':
    ensure => running,
    enable => true,
    require => [File['/jdk-17_linux-x64_bin.rpm'], Exec['jdk17'], File['/opt/minecraft/server.jar'], File['/opt/minecraft/eula.txt'], File['/etc/systemd/system/minecraft.service']],
  }
  /*****************************/
}
