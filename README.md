windows_ad
==========

Puppet module for Windows Active Directory. This module will install ADDS role on a Windows Server 2008 R2 machine 
and configure a new domain forest.

Usage:

node server2008r2a {

  class {"windows_ad":
    path     => "C:\\Users\\vagrant\\Documents\\", # Path for answers file
    filename => "ad_install_unattended", # Name of answers file
    addomain => "seteam.test.com", # domain forest you want to create
  }
}

The machine is going to reboot, several times. On the final reboot, you'll no longer be able to log in with a local user
account, as all of them will be automatically converted to a domain user account. For instance, logging into my vagrant 
environment becomes seteam.test.com\vagrant with the same password as before using the above usage example.

Outstanding TO-DO's:
 - Clean up code
 - Move some things to hiera?
 - ?
