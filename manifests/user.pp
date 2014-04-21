class ad::user ($password){

  user { 'Administrator':
    password => "${password}",
  }

}
