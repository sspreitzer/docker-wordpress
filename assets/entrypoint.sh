#!/bin/bash

set -e

if [ ! -f /var/www/html/index.php ]; then
  cp -r /opt/wordpress/* /var/www/html/
fi

exec $*
