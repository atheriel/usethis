#!/bin/bash
CONFIGURES=($(git diff --cached --name-only | grep -Ei '^configure(\.ac)?$'))
MSG="use 'git commit --no-verify' to override this check"

if [[ ${#CONFIGURES[@]} == 0 ]]; then
  exit 0
fi

if [[ configure.ac -nt configure ]]; then
  echo -e "configure is out of date; please re-run 'autoconf'\n$MSG"
  exit 1
elif [[ ${#CONFIGURES[@]} -lt 2 ]]; then
  echo -e "configure.ac and configure should be both staged\n$MSG"
  exit 1
fi
