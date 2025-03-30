#!/bin/bash
set -e

# Substitute environment variables in the Apache config template
envsubst < /etc/apache2/sites-available/vhost.conf.template > /etc/apache2/sites-available/000-default.conf

# Execute the command passed as arguments (starting Apache)
exec "$@"