# Class: openwa::package
#
# Fetch and configure Open Web Analytics for a generic installation
# Update permissions for standard security
#
# Parameters
# -----------
#
# * 'web_owner'
# This defines the files' owner
#
# * 'web_group'
# This defines the files' group
#
# * 'git_source'
# This is the source for the repository for Open Web Analytics
#
# * 'git_rev'
# This is a control reference tag or revision
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
# Requires
# ---------
#
# puppetlabs-vcsrepo
#
# ===========================
#
# Sample Usage:

class openwa::package (
  $web_group       = $openwa::params::web_group,
  $web_owner       = $openwa::params::web_owner,
  $git_source      = $openwa::params::git_source,
  $git_rev         = $openwa::params::git_rev,
  $database_name   = $openwa::params::database_name,
  $database_host   = $openwa::params::database_host,
  $database_user   = $openwa::params::database_user,
  $database_pass   = $openwa::params::database_pass,
  $website         = $openwa::params::website,
  $website_root    = $openwa::params::website_root,

) inherits openwa::params {

  include ::git

  vcsrepo { $website_root:
    ensure   => latest,
    provider => git,
    source   => $git_source,
    group    => $web_group,
    owner    => $web_owner,
    excludes => ".htaccess\nowa-config.php",
    revision => $git_rev,
    require  => Class['::git'],
  } ->
  file { $website_root:
    ensure  => directory,
    owner   => $web_owner,
    group   => $web_group,
    mode    => '0755',
    require => Vcsrepo[$website_root],
  } ->
  file { "${website_root}/owa-config.php":
    ensure  => file,
    content => epp('openwa/owa-config.epp'),
    group   => $web_group,
    owner   => $web_owner,
    mode    => '0600',
  } ->
  file { "${website_root}/cli.php":
    ensure => file,
    group  => $web_group,
    owner  => $web_owner,
    mode   => '0700',
  }

}
