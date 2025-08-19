#!/bin/bash
cd /home/frappe/frappe-bench
export PATH="/home/frappe/frappe-bench/env/bin:$PATH"
export FRAPPE_SITE=${FRAPPE_SITE_NAME_HEADER}
export REDIS_QUEUE=redis://redis:6379
export REDIS_SOCKETIO=redis://redis:6379

node /home/frappe/frappe-bench/apps/frappe/socketio.js
