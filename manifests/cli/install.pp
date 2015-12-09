# Define: openwa::cli::install
#
# This is a define for cli.php's install command
# /path/to/php5 cli.php cmd=install
#
# Parameters
# -----------
#
# * 'website_root'
# This is the directory where openwa will be installed. Do not forget to include a trailing slash
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
# * 'cli_domain'
# Required - This is the domain of the first web site that you want to track
#
# * 'cli_email'
# Required - This is the email address of the admin user. This is used in password recovery
#
# Requires
# ---------
#
# puppetlabs-stdlib
#
# ===========================
#
# Sample Usage:
#
# openwa::cli { 'setup':
#    cli_domain => 'https://www.somedomain.net/',
#    cli_email  => 'postmaster@somedomain.net',
#  }
#

define openwa::cli::install (
  $website_root = $openwa::params::website_root,
  $web_group    = $openwa::params::web_group,
  $web_owner    = $openwa::params::web_owner,
  $cli_php_path = $openwa::params::cli_php_path,
  $cli_script   = $openwa::params::cli_script,
  $cli_domain   = '',
  $cli_email    = '',
) {

  include stdlib

  validate_string($cli_domain)
  validate_string($cli_email)

  exec { $title :
  # This will execute even if you have a site in place - to prevent this, check if the cache data is present
    unless  => "/bin/ls ${website_root}owa-data/caches/1/owa_site/",
    command => "php ${cli_script} cmd=install domain=${cli_domain} email_address=${cli_email}",
    cwd     => $website_root,
    group   => $web_group,
    user    => $web_owner,
    path    => $cli_php_path,
  }

}
