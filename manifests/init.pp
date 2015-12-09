# Class: openwa
# ===========================
#
# This class creates a database and fetches Open Web Analytics from GitHub
# This will also setup a basic configuration for initial use
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
# Requires
# ---------
#
# puppetlabs-stdlib
# puppetlabs-git
# puppetlabs-mysql
# puppetlabs-vcsrepo
#
# ===========================
#
# Sample Usage:

class openwa (
  $database_name = $openwa::params::database_name,
  $database_host = $openwa::params::database_host,
  $database_user = $openwa::params::database_user,
  $database_pass = $openwa::params::database_pass,
  $website       = $openwa::params::website,
  $website_root  = $openwa::params::website_root,
  $git_source    = $openwa::params::git_source,
  $git_rev       = $openwa::params::git_rev,
) inherits openwa::params {

  class { 'openwa::database':
    database_name => $database_name,
    database_host => $database_host,
    database_user => $database_user,
    database_pass => $database_pass,
  } ->
  class { 'openwa::package':
    database_name => $database_name,
    database_host => $database_host,
    database_user => $database_user,
    database_pass => $database_pass,
    website       => $website,
    website_root  => $website_root,
    git_source    => $git_source,
    git_rev       => $git_rev,
  }

}
