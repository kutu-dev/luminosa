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
  docker compose -f /srv/services/minecraft/compose.yaml exec "$server_name" "$@"
}

rcon() {
  docker_exec rcon-cli "$1"
}

server_version=$(docker_exec sh -c 'echo $VERSION')
backup_filename="$server_name-$(date +%Y-%m-%d)-$server_version.tar.gz"

rcon 'tellraw @a ["",{"text":"[LUMINOSA]:","bold":true,"color":"light_purple"},{"text":" Backing up server world..."}]'
rcon save-off
rcon save-all

backup_directory="/srv/remote/minecraft/$server_name"
backup_path="$backup_directory/$backup_filename"

mkdir -p "$backup_directory"
cd "/srv/sync/minecraft/servers/$server_name/"

tar -czf "$backup_path" world
chown hope:hope -R "$backup_directory"
rcon save-on

rcon 'tellraw @a ["",{"text":"[LUMINOSA]:","bold":true,"color":"light_purple"},{"text":" Backup complete!"}]'
