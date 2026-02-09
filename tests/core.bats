#!/usr/bin/env bats

setup() {
  PROJNAME=my-drupal-site
  load 'common-setup'
  _common_setup
}

# executed after each test
teardown() {
  _common_teardown
}

setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-spidergram-ddev-addon
  mkdir -p $TESTDIR
  export PROJNAME=test-spidergram-ddev-addon
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}


@test "Setup Drupal Core with $(ddev --version)" {
  # mkdir my-drupal-site && cd my-drupal-site
  run mkdir my-drupal-site && cd my-drupal-site
  assert_success
  # ddev config --project-type=drupal11 --docroot=web --database=mariadb:11.8
  run ddev config --project-type=drupal11 --docroot=web --database=mariadb:11.8
  assert_success
  # ddev composer create-project joachim-n/drupal-core-development-project -y
  run bats_pipe printf "yes\nyes\n" \| composer create-project joachim-n/drupal-core-development-project
  assert_success
  assert_output --partial "Do you trust \"drupal/core-recipe-unpack\" to execute code and wish to enable it now?"
  assert_output --partial "Do you trust "tbachert/spi" to execute code and wish to enable it now?"
  #assert_file_not_exist compose.yaml
  #assert_file_not_exist compose.override.yaml

  
  #assert_success
  ## ddev add-on get ddev/ddev-drupal-contribution
  #run ddev add-on get ddev/ddev-drupal-contribution
  #assert_success
  ## ddev restart
  #run ddev restart
  #assert_success
  ##ddev drush site:install --account-name=admin --account-pass=admin -y
  #run ddev drush site:install --account-name=admin --account-pass=admin -y
  #assert_success
  ## PHPUnit functional test
  #run ddev phpunit ./core/modules/migrate/tests/src/Functional/process/DownloadFunctionalTest.php
  #assert_success
  ## PHPUnit js functional test
  #run ddev phpunit ./core/modules/system/tests/src/FunctionalJavascript/FrameworkTest.php
  #assert_success
  ## PHPStan
  #ddev phpstan web/core/modules/navigation
  #assert_success
  #
  #assert_output --partial "100%"
  ## PHPCS
  #ddev phpcs web/core/modules/navigation
  #assert_success
  ## Drupal test traits
  #ddev exec -d /var/www/html/web "../vendor/bin/phpunit --log-junit dtt.junit.xml --bootstrap=../vendor/weitzman/drupal-test-traits/src/bootstrap-fast.php ../vendor/weitzman/drupal-test-traits/tests/ExampleSelenium2DriverTest.php"
  #assert_success
#
  ## Try to add a contrib module compatible with Drupal 12
  #ddev addrepo skipto
  #assert_success
#


  # validate running project

}