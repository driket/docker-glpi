#!/bin/bash
# - Install GLPI if not already installed
# - Run apache in foreground

### GENERAL CONF ###############################################################

APACHE_DIR="/var/www/html"
GLPI_DIR="${APACHE_DIR}/glpi"
GLPI_SOURCE_URL="https://forge.glpi-project.org/attachments/download/2020/glpi-0.85.4.tar.gz"

### INSTALL GLPI IF NOT INSTALLED ALREADY ######################################

if [ ! -d "$GLPI_DIR" ]; then
  echo '-----------> Install GLPI'
  wget -O /tmp/glpi.tar.gz $GLPI_SOURCE_URL --no-check-certificate
  tar -C $APACHE_DIR -xzf /tmp/glpi.tar.gz
  chown -R www-data $GLPI_DIR
fi

### REMOVE THE DEFAULT INDEX.HTML TO LET HTACCESS REDIRECTION ##################

rm ${APACHE_DIR}/index.html

### RUN APACHE IN FOREGROUND ###################################################

# stop apache service
service apache2 stop

# start apache in foreground
source /etc/apache2/envvars
/usr/sbin/apache2 -D FOREGROUND -D FOREGROUND
