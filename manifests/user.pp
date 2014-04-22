class windows_ad::user ($password){

  user { 'Administrator':
    password => "${password}",
  }

}
