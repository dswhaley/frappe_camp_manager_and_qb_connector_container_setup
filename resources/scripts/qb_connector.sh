#!/bin/bash
cd /home/frappe/frappe-bench/apps/qb_connector/ts_qbo_client 
npx ts-node src/index.ts >> /tmp/qb_connector.log 2>&1
