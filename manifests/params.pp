# Class openwa::params
#
# This will handle the parameters management
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
# * 'website_root'
# This is the directory where openwa will be installed on the file system.
# Do not forget to include a trailing slash
#
# * 'website'
# This information defines the URL in the configuration which defaults to the FQDN of the system
#
# * 'git_source'
# This is the source for the repository for Open Web Analytics
#
# * 'git_rev'
# This is a control reference tag or revision
#
# * 'web_owner'
# This defines the files' owner
#
# * 'web_group'
# This defines the files' group
#
# * 'cli_php_path'
# This is the path for php for your cli.php executions
#
# * 'cli_script'
# This is the name of your cli.php if you change it
#
# ===========================

class openwa::params {
  $database_name = 'openwa'
  $database_host = 'localhost'
  $database_user = 'openwa'
  $database_pass = '$uper$ecurepa$$'
  $website_root  = '/var/www/html/'
  $website       = $::fqdn
  $git_source    = 'https://github.com/padams/Open-Web-Analytics.git'
  $git_rev       = '1.5.7'
  $web_owner     = 'apache'
  $web_group     = 'apache'
  $cli_php_path  = ['/usr/bin/', ]
  $cli_script    = 'cli.php'

}
