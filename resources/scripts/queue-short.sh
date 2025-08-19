#!/bin/bash
cd /home/frappe/frappe-bench 
export PATH="/home/frappe/frappe-bench/env/bin:$PATH"
bench worker --queue long,default,short