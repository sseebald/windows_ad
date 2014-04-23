class windows_ad (
  $path,
  $filename,
  $admin_password = 'puppetlabs123!',
  $newdomaindnsname = 'seteam.test.com',
) {

  reboot { 'windows_ad_pre_pending':
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
  reboot { 'windows_ad_post_AdministrativeCenter':
    subscribe => Dism['DirectoryServices-AdministrativeCenter'],
  }

  class { 'windows_ad::user':
    password => $admin_password,
  }

  windows_ad::answers { "${filename}":
    name             => $filename,
    answerspath      => $path,
    newdomaindnsname => $newdomaindnsname,
    require          => Class['windows_ad::user'],
  }

  exec { 'install ad':
    command   => "cmd.exe /c %WINDIR%\Sysnative\dcpromo.exe /unattend:${path}${filename}",
    require   => Windows_Ad::Answers["$filename"],
    path      => $::path,
    #provider => powershell,
  }

}
