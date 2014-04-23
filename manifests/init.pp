class windows_ad ($path,$filename){

  reboot { 'before':
    when => pending,
  }

  Dism {
    ensure => present,
    before => Windows_Ad::Answers["${filename}"],
  }

  dism { 'NetFx3':} ->
  dism { 'ActiveDirectory-PowerShell':} ->
  dism { 'DirectoryServices-DomainController':} ->
  dism { 'DirectoryServices-DomainController-Tools':} ->
  dism { 'DirectoryServices-AdministrativeCenter':}
  reboot { 'now':
    subscribe => Dism['DirectoryServices-AdministrativeCenter'],
  }

  class { 'windows_ad::user':
    password => 'puppetlabs123!',
  }

  windows_ad::answers { "${filename}":
    name             => $filename,
    answerspath      => $path,
    newdomaindnsname => 'seteam.test.com',
    require          => Class['windows_ad::user'],
  }

  exec { 'install ad':
    command   => "cmd.exe /c %WINDIR%\Sysnative\dcpromo.exe /unattend:${path}${filename}",
    require   => Windows_Ad::Answers["$filename"],
    path      => $::path,
    #provider => powershell,
  }

}
