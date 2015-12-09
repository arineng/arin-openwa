# Class openwa::database
# ===========================
#
# Create the Open Web Analytics Database and User
#
# Parameters 
# -----------
#
# * 'database_name'
# This is the name of your database, such as openwa
#
# * 'database_host'
# This is the host of your database, such as localhost
#
# * 'database_user'
# This is the database user which would have access to the database
#
# * 'database_pass'
# This is the password your user requires to access the database
# This password is also used if the openwa::cli::install class is used
#
# Requires
# ---------
#
# puppetlabs-mysql
#
# ===========================
#
# Sample Usage:

class openwa::database (
  $database_name = $openwa::params::database_name,
  $database_host = $openwa::params::database_host,
  $database_user = $openwa::params::database_user,
  $database_pass = $openwa::params::database_pass,
) inherits openwa::params {

  ::mysql::db { $database_name:
    user     => $database_user,
    password => $database_pass,
    host     => $database_host,
    grant    => ['ALL'],
  }

}
