#!/bin/bash
# run-gunicorn.sh

# Navigate to the sites directory (optional, since --chdir is used)
cd /home/frappe/frappe-bench/sites

# Run gunicorn with the same options
/home/frappe/frappe-bench/env/bin/gunicorn \
  --chdir=/home/frappe/frappe-bench/sites \
  --bind=0.0.0.0:8000 \
  --threads=4 \
  --workers=2 \
  --worker-class=gthread \
  --worker-tmp-dir=/dev/shm \
  --timeout=120 \
  --preload \
  frappe.app:application 
