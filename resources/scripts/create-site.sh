#!/bin/bash
echo "Starting setup process" > /tmp/create-site.log
wait-for-it -t 120 $DB_HOST:$DB_PORT >> /tmp/create-site.log 2>&1 || { echo "Failed to connect to db:$DB_PORT" >> /tmp/create-site.log; exit 1; }
echo "Connected to $DB_HOST:$DB_PORT" >> /tmp/create-site.log
wait-for-it -t 120 localhost:6379 >> /tmp/create-site.log 2>&1 || { echo "Failed to connect to redis:6379" >> /tmp/create-site.log; exit 1; }
echo "Connected to redis:6379" >> /tmp/create-site.log
export start=`date +%s`
echo "Checking for sites/common_site_config.json" >> /tmp/create-site.log
until [[ -n `grep -hs ^ sites/common_site_config.json | jq -r ".db_host // empty"` ]] && \
  [[ -n `grep -hs ^ sites/common_site_config.json | jq -r ".redis_cache // empty"` ]] && \
  [[ -n `grep -hs ^ sites/common_site_config.json | jq -r ".redis_queue // empty"` ]]; do
  echo "Waiting for sites/common_site_config.json to be created" >> /tmp/create-site.log
  sleep 5
  if (( `date +%s`-start > 120 )); then
    echo "Could not find sites/common_site_config.json with required keys after 120 seconds" >> /tmp/create-site.log
    exit 1
  fi
done
echo "sites/common_site_config.json found with required keys" >> /tmp/create-site.log
echo "Creating new site with bench" >> /tmp/create-site.log
bench new-site frontend \
  --db-name "$DB_NAME" \
  --db-user "$DB_USER" \
  --db-password "$DB_PASSWORD" \
  --db-host "$DB_HOST" \
  --db-port "$DB_PORT" \
  --admin-password "$ADMIN_PASSWORD" \
  --install-app erpnext >> /tmp/create-site.log 2>&1 || { echo "Failed to create new site" >> /tmp/create-site.log; exit 1; }
bench --site frontend set-config developer_mode 1
bench --site frontend set-config scheduler_enabled 1
bench --site frontend install-app qb_connector >> /tmp/create-site.log
bench --site frontend install-app camp_manager >> /tmp/create-site.log
echo "Site creation completed successfully" >> /tmp/create-site.log