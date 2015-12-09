# Define: openwa::cli::add_site
#
# This is a define for cli.php's add-site command
# This would be used to add an additional site to be tracked
# /path/to/php5 cli.php cmd=add-site
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
# required - the domain of the web site that you want to track. Best practice is to include the protocol (e.g. https://www.somedomain.net/)
#
# * 'cli_name'
# optional - the name that you want to see the site listed as in the site roster
#
# * 'cli_desc'
# optional - a short description of the site
#
# * 'cli_site_family'
# optional - the name of the site family/group that this site should be included in
#
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
# openwa::cli::add_site { 'somedomain.net':
#    cli_domain => 'https://www.somedomain.net/'
# }
#

define openwa::cli::add_site (
  $website_root    = $openwa::params::website_root,
  $web_group       = $openwa::params::web_group,
  $web_owner       = $openwa::params::web_owner,
  $cli_php_path    = $openwa::params::cli_php_path,
  $cli_script      = $openwa::params::cli_script,
  $cli_domain      = '',
  $cli_name        = '',
  $cli_desc        = '',
  $cli_site_family = '',
) {

  include stdlib

  validate_string($cli_domain)

  exec { $title :
    command => "php ${cli_script} cmd=add-site domain=${cli_domain} name=${cli_name} description=\"${cli_desc}\" site_family=${cli_site_family}",
    cwd     => $website_root,
    group   => $web_group,
    user    => $web_owner,
    path    => $cli_php_path,
  }

}
