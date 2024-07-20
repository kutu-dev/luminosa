#!/usr/bin/env sh
set -eu

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run by root" >&2
  exit 1
fi

/srv/services/loff/scripts/backup-server.sh alfheim
/srv/services/loff/scripts/backup-server.sh hub
