#!/usr/bin/env bats

# Bats is a testing framework for Bash
# Documentation https://bats-core.readthedocs.io/en/stable/
# Bats libraries documentation https://github.com/ztombol/bats-docs

# For local tests, install bats-core, bats-assert, bats-file, bats-support
# And run this in the add-on root directory:
#   bats ./tests/test.bats
# To exclude release tests:
#   bats ./tests/test.bats --filter-tags '!release'
# For debugging:
#   bats ./tests/test.bats --show-output-of-passing-tests --verbose-run --print-output-on-failure

setup() {
  set -eu -o pipefail

  # Override this variable for your add-on:
  export GITHUB_REPO=rpkoller/ddev-drupal-contribution

  TEST_BREW_PREFIX="$(brew --prefix 2>/dev/null || true)"
  export BATS_LIB_PATH="${BATS_LIB_PATH}:${TEST_BREW_PREFIX}/lib:/usr/lib/bats"
  bats_load_library bats-assert
  bats_load_library bats-file
  bats_load_library bats-support

  export DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/.." >/dev/null 2>&1 && pwd)"
  export PROJNAME="test-$(basename "${GITHUB_REPO}")"
  mkdir -p "${HOME}/tmp"
  export TESTDIR="$(mktemp -d "${HOME}/tmp/${PROJNAME}.XXXXXX")"
  export DDEV_NONINTERACTIVE=true
  export DDEV_NO_INSTRUMENTATION=true
  ddev delete -Oy "${PROJNAME}" >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  run ddev config --project-name="${PROJNAME}" --project-tld=ddev.site --project-type=drupal12 --docroot=web --database=mariadb:11.8
  assert_success
  run ddev start -y
  assert_success
}

health_checks() {
  # Do something useful here that verifies the add-on

  # You can check for specific information in headers:
  # run curl -sfI https://${PROJNAME}.ddev.site
  # assert_output --partial "HTTP/2 200"
  # assert_output --partial "test_header"

  # Or check if some command gives expected output:
  DDEV_DEBUG=true run ddev launch
  assert_success
  assert_output --partial "FULLURL https://${PROJNAME}.ddev.site"
}

teardown() {
  set -eu -o pipefail
  ddev delete -Oy "${PROJNAME}" >/dev/null 2>&1
  # Persist TESTDIR if running inside GitHub Actions. Useful for uploading test result artifacts
  # See example at https://github.com/ddev/github-action-add-on-test#preserving-artifacts
  if [ -n "${GITHUB_ENV:-}" ]; then
    [ -e "${GITHUB_ENV:-}" ] && echo "TESTDIR=${HOME}/tmp/${PROJNAME}" >> "${GITHUB_ENV}"
  else
    [ "${TESTDIR}" != "" ] && rm -rf "${TESTDIR}"
  fi
}

@test "Setup Drupal Core with $(ddev --version)" {
  set -eu -o pipefail
  # ddev composer create-project joachim-n/drupal-core-development-project -y
  run ddev composer create-project joachim-n/drupal-core-development-project
  assert_success
  ## ddev add-on get ddev/ddev-drupal-contribution
  run ddev add-on get ddev/ddev-drupal-contribution
  assert_success
  ## ddev restart
  run ddev restart
  assert_success
  ##ddev drush site:install --account-name=admin --account-pass=admin -y
  run ddev drush site:install --account-name=admin --account-pass=admin -y
  assert_success
  ### PHPUnit functional test
  #run ddev phpunit ./core/modules/migrate/tests/src/Functional/process/DownloadFunctionalTest.php
  #assert_success
  ### PHPUnit js functional test
  #run ddev phpunit ./core/modules/system/tests/src/FunctionalJavascript/FrameworkTest.php
  #assert_success
  ### PHPStan
  #ddev phpstan web/core/modules/navigation
  #assert_success
  ##assert_output --partial "100%"
  ### PHPCS
  #ddev phpcs web/core/modules/navigation
  #assert_success
  ### Drupal test traits
  #ddev exec -d /var/www/html/web "../vendor/bin/phpunit --log-junit dtt.junit.xml --bootstrap=../vendor/weitzman/drupal-test-traits/src/bootstrap-fast.php ../vendor/weitzman/drupal-test-traits/tests/ExampleSelenium2DriverTest.php"
  #assert_success
  ### Try to add a contrib module compatible with Drupal 12
  #ddev addrepo skipto
  #assert_success

  # validate running project
  health_checks

}


# bats test_tags=release
#@test "install from release" {
#  set -eu -o pipefail
#  echo "# ddev add-on get ${GITHUB_REPO} with project ${PROJNAME} in $(pwd)" >&3
#  run ddev add-on get "${GITHUB_REPO}"
#  assert_success
#  run ddev restart -y
#  assert_success
#  health_checks
#}
