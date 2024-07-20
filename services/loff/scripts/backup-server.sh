#!/usr/bin/env sh
set -eu

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run by root" >&2
  exit 1
fi

if [ -z "$1" ]; then
  echo "Missing server name" >&2
  exit 2
fi

server_name="$1"

docker_exec() {
  docker compose -f "/srv/services/loff/compose.yaml" exec "$server_name" "$@"
}

rcon() {
  docker_exec rcon-cli "$1"
}

server_version=$(docker_exec sh -c 'echo $VERSION')
backup_filename="$server_name-$(date +%Y-%m-%d)-$server_version.tar.gz"

rcon 'tellraw @a ["",{"text":"[","bold":true},{"text":"LUMINOSA","bold":true,"color":"light_purple"},{"text":"]:","bold":true},{"text":" Backing up server world..."}]'
rcon save-off
rcon save-all

sleep 2

backup_directory="/srv/remote/loff/$server_name"
backup_path="$backup_directory/$backup_filename"

mkdir -p "$backup_directory"
cd "/srv/sync/loff/servers/$server_name/"

tar --ignore-failed-read -czf "$backup_path" world
chown hope:hope -R "$backup_directory"
rcon save-on

rcon 'tellraw @a ["",{"text":"[","bold":true},{"text":"LUMINOSA","bold":true,"color":"light_purple"},{"text":"]:","bold":true},{"text":" Backup complete!"}]'
