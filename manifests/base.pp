
include wget 

Exec {
  path => '/bin:/sbin/:/usr/bin/:/usr/sbin/',
} 

package{'icu':}

package{'curl':}

file{'/opt/dotnet':
  ensure => directory
}

-> wget::fetch { 'download aspnetcore package':
  source      => 'https://download.visualstudio.microsoft.com/download/pr/468a5b22-f817-4e62-a8b3-517907c54aaa/903657aec3df949337c37a9532e8e315/dotnet-sdk-2.2.101-rhel.6-x64.tar.gz',
  destination => '/opt/dotnet/',
  timeout     => 0,
  verbose     => false,
}

exec {'unpacks aspnetcore': 
  command => 'tar -zxvf /opt/dotnet/dotnet-sdk-2.2.101-rhel.6-x64.tar.gz',
  cwd     => '/opt/dotnet/',
  require => Wget::Fetch['download aspnetcore package'],
}

-> exec {'delete package': 
  command => 'rm -f /opt/dotnet/dotnet-sdk-2.2.101-rhel.6-x64.tar.gz',
  cwd     => '/opt/dotnet/',
}
