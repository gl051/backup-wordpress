#!/bin/bash
# Author Gianluca Biccari

# Get site name which must be a parameter provided
if [ $# -eq 0 ]
  then
    echo "$(date "+%F %H:%M:%S.%N") - No site name supplied"
	exit 1
else
	SITE_NAME=$1
fi

BACKUP_TIMESTAMP=$(date +%Y%m%dT%H%M%S)
BACKUP_LOG=backup_$SITE_NAME.log
echo "$(date "+%F %H:%M:%S.%N") - Backup for WP site ${SITE_NAME} started" >> $BACKUP_LOG

# Check if the site directoty exists
SITE_LOCATION=${HOME}/public_html/$SITE_NAME
if [ ! -d "$SITE_LOCATION" ]; then
  echo "$(date "+%F %H:%M:%S.%N") - The site directory does not exists (${SITE_LOCATION})" >> $BACKUP_LOG
  exit 1
fi

# Create backup folder if necessary
BACKUP_LOCATION=${HOME}/backups/wp-sites/$SITE_NAME
echo "$(date "+%F %H:%M:%S.%N") - Check on the backup location at ${BACKUP_LOCATION}" >> $BACKUP_LOG
mkdir -p ${BACKUP_LOCATION}

# Get mysql credentials
DB_NAME=$(grep DB_NAME "${SITE_LOCATION}/wp-config.php" | cut -f4 -d"'")
DB_USER=$(grep DB_USER "${SITE_LOCATION}/wp-config.php" | cut -f4 -d"'")
DB_PASSWORD=$(grep DB_PASSWORD "${SITE_LOCATION}/wp-config.php" | cut -f4 -d"'")

# Create backup database
echo "$(date "+%F %H:%M:%S.%N") - Backup of MySQL Database (${DB_NAME}) started" >> $BACKUP_LOG 
BACKUP_DB=${BACKUP_LOCATION}/${BACKUP_TIMESTAMP}_${SITE_NAME}_db.sql
mysqldump --add-drop-table -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DB
echo "$(date "+%F %H:%M:%S.%N") - Backup of MySQL Database (${DB_NAME}) completed." >> $BACKUP_LOG

# Create backup files
echo "$(date "+%F %H:%M:%S.%N") - WP files backup started" >> $BACKUP_LOG
BACKUP_FILES=${BACKUP_LOCATION}/${BACKUP_TIMESTAMP}_${SITE_NAME}_files.tar.gz
# Using the -C option to avoid using a full path which is not good practice and can bring to risk
SITE_LOCATION_RELATIVE_PATH=${SITE_LOCATION#"/"}
tar czf $BACKUP_FILES -C / $SITE_LOCATION_RELATIVE_PATH
echo "$(date "+%F %H:%M:%S.%N") - WP files backup completed" >> $BACKUP_LOG
echo "$(date "+%F %H:%M:%S.%N") - Backup files: ${BACKUP_FILES}" >> $BACKUP_LOG
echo "$(date "+%F %H:%M:%S.%N") - Backup database: ${BACKUP_DB}" >> $BACKUP_LOG
echo "$(date "+%F %H:%M:%S.%N") - WP site ${SITE_NAME} completed" >> $BACKUP_LOG