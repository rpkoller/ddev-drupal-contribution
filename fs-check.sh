#!/usr/bin/env bash

# Create two files with a differing capitalization
touch testfile
touch TESTFILE

# Check if both files exist
if ls | grep -q 'TESTFILE' && ls | grep -q 'testfile'; then
  echo "Case-sensitive file system, no action necessary"
else
  git -C ../repos/drupal config core.ignorecase true
  echo "None case-sensitive file system, ignorecase git configuration setting is set to true for the drupal repository"
fi

# Clean up
rm -f testfile TESTFILE