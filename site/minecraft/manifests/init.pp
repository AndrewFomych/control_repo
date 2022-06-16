class minecraft(
  $install_dir = '/opt/minecraft',
  $java_url = 'https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm',
  $minecraft_url = 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar'
  ){
  file{$install_dir:
    ensure => directory,
  }
  
  /***Install Java***/
  /*include java
  java::download { 'jdk17':
    ensure  => 'present',
    java_se => 'jdk',
    url     => $java_url,
  }*/
  /*package {'java':
    ensure => present,
  }*/
  file{'/jdk-17_linux-x64_bin.rpm':
    ensure => file,
    source => $java_url,
  }
  exec{'jdk17':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'sudo rpm -ivh jdk-17_linux-x64_bin.rpm ; rm -f jdk-17_linux-x64_bin.rpm',
  }
  /*****************************/
  
  /***Install Minecraft Server***/
  file{"$install_dir/server.jar":
    ensure => file,
    source => $minecraft_url,
  }
  /*file {'/opt/minecraft/server.jar':
    ensure => file,
    source      => 'https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar', /*old URL minecraft*/
  }*/
  /*****************************/
  
  /*** Needed file for the confirmation ***/
  file{"$install_dir/eula.txt":
    ensure  => file,
    content => 'eula=true',
  }
  /*****************************/
  
  /*** File for autostart server ***/
  file{'/etc/systemd/system/minecraft.service':
    ensure => file,
    content => epp('minecraft/minecraft.service', {
      install_dir => $install_dir
    }),
  }
  /*****************************/
  
  /*** Enable autostart server ***/
  service{'minecraft':
    ensure => running,
    enable => true,
    require => [File['/jdk-17_linux-x64_bin.rpm'], Exec['jdk17'], File["$install_dir/server.jar"], File["$install_dir/eula.txt"], File['/etc/systemd/system/minecraft.service']],
  }
  /*****************************/
}
