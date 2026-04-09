#!/usr/bin/env bash

cat <<EOF >> ${DDEV_APPROOT}/repos/drupal/.git/info/exclude
/sites/simpletest
/vendor
/.vscode
EOF

echo "Simpletest, vendor, and .vscode folders successfully added to the git exclude list"
