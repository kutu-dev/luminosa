# Default recipe for the justfile
default: help

# Show this info message
help:
  just --list

# Stop all containers
stop-all:
  docker stop $(docker ps -a -q)

# Clear all Docker data from the system
clear:
  docker rm $(docker ps -a -q)
