[![add-on registry](https://img.shields.io/badge/DDEV-Add--on_Registry-blue)](https://addons.ddev.com)
[![tests](https://github.com/rpkoller/ddev-drupal-contribution/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/rpkoller/ddev-drupal-contribution/actions/workflows/tests.yml?query=branch%3Amain)
[![last commit](https://img.shields.io/github/last-commit/rpkoller/ddev-drupal-contribution)](https://github.com/rpkoller/ddev-drupal-contribution/commits)
[![release](https://img.shields.io/github/v/release/rpkoller/ddev-drupal-contribution)](https://github.com/rpkoller/ddev-drupal-contribution/releases/latest)

# DDEV Drupal Contribution

## Overview

## Installation

[!CAUTION]
The addon is not suited for the general usage yet. It is still in early development. Projects a properly set up and are functional but the different tests are not functional yet. 

```bash
ddev config --project-type=drupal12 --docroot=web
ddev composer create-project joachim-n/drupal-core-development-project
ddev composer require drush/drush
ddev add-on get rpkoller/ddev-drupal-contribution
ddev restart
ddev drush si standard --account-name=admin --account-pass=admin -y
```

## Install a contrib module
Simply install a contributed module with 
```bash
ddev addrepo skipto
```
The command will git clone the repo into the `repos` folder. Then it will add the module to the repositories section of the `composer.json file`, which is necessary for the next optional step. To make the module actually install-able within the site it has to be symlinked by `composer require` the module. The only requirement, the version you want to work on has to satify the drupal 12 version requirment. So with a module like Skipto that is already compatible with Drupal 12 you are able to proceed without a problem, while for a module not compatible with Drupal 12 yet you should answer with `no` to the question if you want to symlink the module. 

## Testing


### PHPUnit functional tests
[!WARNING] 
Not functional yet, this is just a placeholder and reminder.

```bash
ddev phpunit ./core/modules/migrate/tests/src/Functional/process/DownloadFunctionalTest.php
```

### PHPUnit JS functional tests
[!WARNING] 
Not functional yet, this is just a placeholder and reminder.

```bash
ddev phpunit ./core/modules/system/tests/src/FunctionalJavascript/FrameworkTest.php
```

### PHPStan
[!WARNING] 
Not functional yet, this is just a placeholder and reminder.

```bash
ddev phpstan web/core/modules/navigation
```

### PHPcs
[!WARNING] 
Not functional yet, this is just a placeholder and reminder.

```bash
ddev phpcs web/core/modules/navigation
```

### Nightwatch
[!WARNING] 
Not functional yet, this is just a placeholder and reminder.

```bash
ddev nightwatch tests/Drupal/Nightwatch/Tests/exampleTest.js
```

### Drupal Test Traits
[!WARNING] 
Not functional yet, this is just a placeholder and reminder.

```bash
ddev exec -d /var/www/html/web "../vendor/bin/phpunit --log-junit dtt.junit.xml --bootstrap=../vendor/weitzman/drupal-test-traits/src/bootstrap-fast.php ../vendor/weitzman/drupal-test-traits/tests/ExampleSelenium2DriverTest.php"
```


## Credits

**Contributed and maintained by [@rpkoller](https://github.com/rpkoller)**
