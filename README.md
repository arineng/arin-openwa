# openwa

#### Table of Contents

1. [Module Description](#module-description)
2. [Setup](#setup)
    * [What openwa affects](#what-openwa-affects)
    * [Setup requirements](#setup-requirements)
3. [Usage](#usage)
4. [Reference](#reference)
    * [Public Classes](#public-classes)
    * [Public Defines](#public-defines)

## Module Description

This module is designed to fetch and perform a very basic configuration of [Open Web Analytics](https://github.com/padams/Open-Web-Analytics) with very basic security in place to allow for immediate
usage of the software on any LAMP stack.

## Setup

### What openwa affects

* This module will fetch a GitHub repository into a directory that is defined
* Various permissions of the files fetched are modified to prevent security risk
* A database is created for the usage of the software

### Setup Requirements

For information as to what this module requires, please first see https://github.com/padams/Open-Web-Analytics/wiki/Technical_Requirements.

Most important being PHP with MySQL and necessary extensions. This module also does require [puppetlabs-mysql](https://forge.puppetlabs.com/puppetlabs/mysql) to configure the database on your platform.

## Usage

To simply configure Open Web Analytics:

```puppet
include openwa
```

You may also use the cli/install define to setup OpenWA if you have provided a configuration

Alternatively after you have setup Open Web Analytics, you can add additional sites:

```puppet
openwa::cli::add_site { 'somedomain.net':
    cli_domain => 'https://www.somedomain.net',
}
```

## Reference

- [**Public Classes**](#public-classes)
    - [Class: openwa](#class-openwa)
    - [Class: openwa::package](#class-openwapackage)
    - [Class: openwa::database](#class-openwadatabase)
    - [Class: openwa::cli](#class-openwacli)
- [**Public Defines**](#public-defines)
    - [Define: openwa::site_settings](#define-openwasite_settings)
    - [Define: openwa::cli::install](#define-openwacliinstall)
    - [Define: openwa::cli::add_site](#define-openwacliadd_site)

### Public Classes

#### Class: `openwa`

This class creates a database and fetches Open Web Analytics from GitHub

This will also setup a basic configuration for initial use

**Parameters within `openwa`:**

##### `database_name`
This is the name of your database, such as openwa

##### `database_host`
This is the host of your database, such as localhost

##### `database_user`
This is the database user which would have access to the database

##### `database_pass`
This is the password your user requires to access the database

This password is also used if the openwa::cli::install class is used

##### `website_root`
This is the directory where openwa will be installed on the file system.

Do not forget to include a trailing slash

##### `website`
This information defines the URL in the configuration which defaults to the FQDN of the system

##### `git_source`
This is the source for the repository for Open Web Analytics

##### `git_rev`
This is a control reference tag or revision

#### Class: `openwa::package`

Fetch and configure Open Web Analytics for a generic installation  

Update permissions for standard security

**Parameters within `openwa::package`:**

##### `web_owner`
This defines the files' owner

##### `web_group`
This defines the files' group

##### `git_source`
This is the source for the repository for Open Web Analytics

##### `git_rev`
This is a control reference tag or revision

##### `database_name`
This is the name of your database, such as openwa

##### `database_host`
This is the host of your database, such as localhost

##### `database_user`
This is the database user which would have access to the database

##### `database_pass`
This is the password your user requires to access the database

This password is also used if the openwa::cli::install class is used

##### `website_root`
This is the directory where openwa will be installed on the file system.

Do not forget to include a trailing slash

##### `website`
This information defines the URL in the configuration which defaults to the FQDN of the system

#### Class: `openwa::database`

Create the Open Web Analytics Database and User

**Parameters within `openwa::database`:**

##### `database_name`
This is the name of your database, such as openwa

##### `database_host`
This is the host of your database, such as localhost

##### `database_user`
This is the database user which would have access to the database

##### `database_pass`
This is the password your user requires to access the database

This password is also used if the openwa::cli::install class is used

#### Class: `openwa::cli`

This will allow puppet to call the cli.php directly

Simple Usage:

```puppet
openwa::cli { 'flush_cache':
    cli_cmd  => 'flush-cache',
    cli_args => '',
}
```

**Parameters within `openwa::cli`:**

##### `website_root`
This is the directory where openwa will be installed. Do not forget to include a trailing slash

##### `web_owner`
This defines the files' owner

##### `web_group`
This defines the files' group

##### `cli_php_path`
This is the path for php for your cli.php executions

##### `cli_script`
This is the name of your cli.php if you change it

##### `cli_args`
This is a custom string of arguments passed for cli.php  

See https://github.com/padams/Open-Web-Analytics/wiki/Command-Line-Interface-%28CLI%29

##### `cli_cmd`
This is the type of command you want to run with cli.php

### Public Defines

#### Define `openwa::site_settings`

Automate the site settings or profile for any existing site

Simple Usage:

```puppet
 openwa::site_settings { 'somedomain.net':
  settings_domain => 'http://www.somedomain.net/',
  filter          => '.+',
  rules           => [
    '(/view1)(/[^/]+) -> \$1',
    '(/view2)(/[^/]+) -> \$1'
  ],
 }
```

**Parameters within `openwa::site_settings`:**

##### `database_name`
 This is the name of your database, such as openwa

##### `database_user`
 This is the database user which would have access to the database

##### `database_pass`
 This is the password your user requires to access the database.
 This password is also used if the openwa::cli::install class is used

##### `mysql_path`
 This will determine where your mysql binary is located

##### `settings_domain`
 This will determine the domain you wish to update the profile for

##### `p3p_policy`
 P3P Compact Privacy Policy under Site Settings
 This setting controls the P3P compact privacy policy that is returned to the
 browser when OWA sets cookies

##### `settings_alias`
 Domain Aliases under Site Settings
 This setting allows you to specify additional domain names that you want OWA
 to treat as the same as the one you are using for this tracked website. For
 example, if the domain of your website is "www.mydomain.com" you could add
 an alias here for "mydomain.com". Aliases should be separated by comma.

##### `filter`
 URL Parameters under Site Settings
 This setting controls the URL parameters that OWA should ignore when
 processing requests. This is useful for avoiding duplicate URLs due to the
 use of tracking or others state parameters in your URLs. Parameter names
 should be separated by comma.

##### `rules`
 Rewrite Rules under Site Settings
 **NOTE** This setting may not be available with your installation as you may have
 to pull in a fork of Open Web Analytics.
 **NOTE** If this value is not present update the settings variable to the
 commented variable.
 This setting controls how to rewrite URLs. Rules should be separated by comma.
 Each rule looks like: (/view)(/[^/]+) -> $1

##### `page`
 Default Page under Site Settings
 This is the page that your web server defaults to when there is no page
 specified in your URL (e.g. index.html). Use this setting to combine page
 views for www.domain.com and www.domain.com/index.html.

##### `enabledecommerce`
 e-commerce Reporting under Site Settings
 Adds e-commerce metrics/statistics to reports. This value will be either
 0 for disabled or 1 for enabled

#### Define `openwa::cli::install`

This is a define for cli.php's install command

Important to note that your owa-config.php must already be setup with your database and URL settings

Simple Usage:

```puppet
openwa::cli { 'setup':
    cli_domain => 'https://www.somedomain.net/',
    cli_email  => 'postmaster@somedomain.net',
}
```

**Parameters within `openwa::cli::install`:**

##### `website_root`
This is the directory where openwa will be installed. Do not forget to include a trailing slash

##### `web_owner`
This defines the files' owner

##### `web_group`
This defines the files' group

##### `cli_php_path`
This is the path for php for your cli.php executions

##### `cli_script`
This is the name of your cli.php if you change it

##### `cli_domain`
Required - This is the domain of the first web site that you want to track

##### `cli_email`
Required - This is the email address of the admin user. This is used in password recovery

#### Define `openwa::cli::add_site`

This is a define for cli.php's add-site command  

This would be used to add an additional site to be tracked

Simple Usage:

```puppet
openwa::cli::add_site { 'somedomain.net':
    cli_domain => 'https://www.somedomain.net/'
}
```

**Parameters within `openwa::cli::add_site`:**

##### `website_root`
This is the directory where openwa will be installed. Do not forget to include a trailing slash

##### `web_owner`
This defines the files' owner

##### `web_group`
This defines the files' group

##### `cli_php_path`
This is the path for php for your cli.php executions

##### `cli_script`
This is the name of your cli.php if you change it

##### `cli_domain`
required - the domain of the web site that you want to track. Best practice is to include the protocol (e.g. https://www.somedomain.net/)

##### `cli_name`
optional - the name that you want to see the site listed as in the site roster

##### `cli_desc`
optional - a short description of the site

##### `cli_site_family`
optional - the name of the site family/group that this site should be included in
