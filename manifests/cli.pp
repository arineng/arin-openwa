# Define: openwa::cli
# ===========================
#
# This will allow puppet to call the cli.php directly
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
# * 'cli_args'
# This is a custom string of arguments passed for cli.php
# See https://github.com/padams/Open-Web-Analytics/wiki/Command-Line-Interface-%28CLI%29
#
# * 'cli_cmd'
# This is the type of command you want to run with cli.php
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
# openwa::cli { 'flush_cache':
#    cli_cmd  => 'flush-cache',
#    cli_args => '',
#  }
#  

define openwa::cli (
  $website_root = $openwa::params::website_root,
  $web_group    = $openwa::params::web_group,
  $web_owner    = $openwa::params::web_owner,
  $cli_php_path = $openwa::params::cli_php_path,
  $cli_script   = $openwa::params::cli_script,
  $cli_args     = '',
  $cli_cmd      = '',
) {

  include stdlib

  validate_string($cli_cmd)
  validate_string($cli_args)

  exec { $title :
    command => "php ${cli_script} ${cli_cmd} ${cli_args}",
    cwd     => $website_root,
    group   => $web_group,
    user    => $web_owner,
    path    => $cli_php_path,
  }

}
