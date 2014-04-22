class ad ($path,$filename){

  reboot { 'before':
    when => pending,
  }

  Dism {
    ensure => present,
    before => Ad::Answers["${filename}"],
  }

  dism { 'NetFx3':} ->
  dism { 'ActiveDirectory-PowerShell':} ->
  dism { 'DirectoryServices-DomainController':} ->
  dism { 'DirectoryServices-DomainController-Tools':} ->
  dism { 'DirectoryServices-AdministrativeCenter':}
  reboot { 'now':
    subscribe => Dism['DirectoryServices-AdministrativeCenter'],
  }

  class { 'ad::user':
    password => 'puppetlabs123!',
  }

  ad::answers { "${filename}":
    name             => $filename,
    answerspath      => $path,
    newdomaindnsname => 'seteam.test.com',
    require          => Class['ad::user'],
  }

  exec { 'install ad':
    command  => "%WINDIR%\Sysnative\dcpromo.exe /unattend:${path}${filename}",
    path     => $::path,
    require  => Ad::Answers["$filename"],
    provider => powershell,
  }

}
