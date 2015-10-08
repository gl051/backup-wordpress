#!/bin/bash
# Author Gianluca Biccari
# Synchronize remote backup directory with a local directory, 
# then remove files succesfully transfered.

# usage: 
#	shell:$> download_backup

# Edit the following parameters according with your situation
REMOTE_LOCATION=www.biccari.com
BACKUP_REMOTE=${REMOTE_LOCATION}:/home/biccaric/backups/wp-sites/
BACKUP_LOCAL=/Users/Gianluca/Backups/Site5/Wordpress

# Download backups
echo "Copy backups from ${REMOTE_LOCATION} started"
echo "Remote location: ${BACKUP_REMOTE}"
echo -n "Enter the user login and press [ENTER]: "
read UserLogin
rsync -avh -e ssh --remove-source-files --progress --exclude '*.sh' $UserLogin@$BACKUP_REMOTE $BACKUP_LOCAL
echo "Copy backups from ${REMOTE_LOCATION} completed."
