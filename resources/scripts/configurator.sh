#!/bin/bash
set -e  # Exit immediately if a command fails
set -x  # Print each command before executing it

echo "Listing apps..."
ls -1 /home/frappe/frappe-bench/apps > /home/frappe/frappe-bench/sites/apps.txt
echo "Apps list written to sites/apps.txt"

echo "Setting database host..."
echo "DB_HOST=$DB_HOST"
bench set-config -g db_host "$DB_HOST"

echo "Setting database port..."
echo "DB_PORT=$DB_PORT"
bench set-config -gp db_port "$DB_PORT"

echo "Setting database user"
echo "DB_USER=$DB_USER"
bench set-config -g db_user "$DB_USER"

echo "Setting database password..."
echo "DB_PASSWORD=$DB_PASSWORD"
bench set-config -g db_password "$DB_PASSWORD"

echo "Setting DB_Name..."
echo "DB_NAME=$DB_NAME"
bench set-config -g db_name "$DB_NAME"

echo "Setting Redis cache..."
echo "REDIS_CACHE=localhost:6379"
bench set-config -g redis_cache "redis://localhost:6379"

echo "Setting Redis queue..."
echo "REDIS_QUEUE=localhost:6379"
bench set-config -g redis_queue "redis://localhost:6379"

echo "Setting Redis socketio..."
bench set-config -g redis_socketio "redis://localhost:6379"

echo "Setting SocketIO port..."
echo "SOCKETIO_PORT=9000"
bench set-config -gp socketio_port "$SOCKETIO_PORT"

echo "Configurator script completed."
