# Define openwa::site_settings
# ===========================
#
# Automate the site settings or profile for any existing site
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
# * 'mysql_path'
# This will determine where your mysql binary is located
#
# * 'settings_domain'
# This will determine the domain you wish to update the profile for
#
# * 'p3p_policy'
# P3P Compact Privacy Policy under Site Settings
# This setting controls the P3P compact privacy policy that is returned to the
# browser when OWA sets cookies
#
# * 'settings_alias'
# Domain Aliases under Site Settings
# This setting allows you to specify additional domain names that you want OWA
# to treat as the same as the one you are using for this tracked website. For 
# example, if the domain of your website is "www.mydomain.com" you could add
# an alias here for "mydomain.com". Aliases should be separated by comma.
#
# * 'filter'
# URL Parameters under Site Settings
# This setting controls the URL parameters that OWA should ignore when
# processing requests. This is useful for avoiding duplicate URLs due to the
# use of tracking or others state parameters in your URLs. Parameter names
# should be separated by comma.
#
# * 'rules'
# Rewrite Rules under Site Settings
# NOTE This setting may not be available with your installation as you may have
# to pull in a fork of Open Web Analytics
# NOTE If this value is not present update the settings variable to the
# commented variable 
# This setting controls how to rewrite URLs. Rules should be separated by comma
# Each rule looks like: (/view)(/[^/]+) -> $1
#
# * 'page'
# Default Page under Site Settings
# This is the page that your web server defaults to when there is no page
# specified in your URL (e.g. index.html). Use this setting to combine page
# views for www.domain.com and www.domain.com/index.html.
#
# * 'enabledecommerce'
# e-commerce Reporting under Site Settings
# Adds e-commerce metrics/statistics to reports. This value will be either
# 0 for disabled or 1 for enabled
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
# openwa::site_settings { 'somedomain.net':
#   settings_domain => 'http://www.somedomain.net/',
#   filter          => '.+',
#   rules					 => [
#     '(/view1)(/[^/]+) -> \$1',
#     '(/view2)(/[^/]+) -> \$1'
#   ],
# }

define openwa::site_settings (
  $database_user    = $openwa::params::database_user,
  $database_pass    = $openwa::params::database_pass,
  $database_name    = $openwa::params::database_name,
  $database_host    = $openwa::params::database_host,
  $mysql_path       = '/usr/bin/',
  $settings_domain  = 'http://somedomain.net/',
  $p3p_policy       = '',
  $settings_alias   = '',
  $filter           = '',
  $rules            = '',
  $page             = '',
  $enableecommerce  = '0',
) {

  include stdlib

  # Variable construction done here

  # rules_joined is to accommodate an array for the $rules parameter
  $rules_joined    = join($rules,', ')
  $p3p_policy_size = size($p3p_policy)
  $alias_size      = size($settings_alias)
  $filter_size     = size($filter)
  $rules_size      = size(regsubst($rules_joined, '\\\\\$', '$', 'G'))
  $page_size       = size($page)
  $settings        = "a:6:{s:10:\\\"p3p_policy\\\";s:${p3p_policy_size}:\\\"${p3p_policy}\\\";s:14:\\\"domain_aliases\\\";s:${alias_size}:\\\"${settings_alias}\\\";s:20:\\\"query_string_filters\\\";s:${filter_size}:\\\"${filter}\\\";s:13:\\\"rewrite_rules\\\";s:${rules_size}:\\\"${rules_joined}\\\";s:12:\\\"default_page\\\";s:${page_size}:\\\"${page}\\\";s:24:\\\"enableEcommerceReporting\\\";s:1:\\\"${enableecommerce}\\\";}"

  # NOTE Use this variable for settings if you do not have the Rewrite Rules option in your Site Settings
  #$settings        = "a:6:{s:10:\\\"p3p_policy\\\";s:${p3p_policy_size}:\\\"${p3p_policy}\\\";s:14:\\\"domain_aliases\\\";s:${alias_size}:\\\"${settings_alias}\\\";s:20:\\\"query_string_filters\\\";s:${filter_size}:\\\"${filter}\\\";s:12:\\\"default_page\\\";s:${page_size}:\\\"${page}\\\";s:24:\\\"enableEcommerceReporting\\\";s:1:\\\"${enableecommerce}\\\";}"

  # Variable construction done

  exec { $title:
    path    => $mysql_path,
    unless  => "mysql -u${database_user} -p${database_pass} -h${database_host} -e \"SELECT domain FROM ${database_name}.owa_site WHERE settings LIKE '${settings}' ;\" | /bin/grep \"${settings_domain}\"",
    command => "mysql -u${database_user} -p${database_pass} -h${database_host} -e \"UPDATE ${database_name}.owa_site SET settings='${settings}' WHERE domain='${settings_domain}'; \"",
  }
}

