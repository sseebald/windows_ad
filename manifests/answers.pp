define windows_ad::answers
(
  $name,
  $answerspath,
  $replicaornewdomain="Domain",
  $newdomain="Forest",
  $newdomaindnsname="test.puppetlabs.com",
  $forestlevel=4,
  $domainnetbiosname="TEST",
  $domainlevel=4,
  $installdns="Yes",
  $confirmgc="Yes",
  $creatednsdelegation="No",
  $databasepath="C:\Windows\NTDS",
  $logpath="C:\Windows\NTDS",
  $sysvolpath="C:\Windows\SYSVOL",
  # Set SafeModeAdminPassword to the correct value prior to using the unattend file
  $safemodeadminpassword="puppetlabs123!",
  # Run-time flags (optional)
  $rebootoncompletion="Yes",
)
{
  #$date = generate('/bin/date', '+%Y%d%m_%H:%M:%S')

  file { "${answerspath}${name}":
    ensure  => file,
    content => template('windows_ad/answers.erb'),
  }
}
