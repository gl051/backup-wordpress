#!/bin/bash
# Author Gianluca Biccari

# Edit the following parameters according with your situation
REMOTE_LOCATION=www.biccari.com
BACKUP_REMOTE=${REMOTE_LOCATION}:/home/biccaric/backups/wp-sites/
BACKUP_LOCAL=/Users/Gianluca/Backups/Site5/Wordpress

# SECTION: help
display_usage() {
  echo "- Description:"
	echo "Download all WordPress Sites backups from ${REMOTE_LOCATION}"
  echo "Backups are saved into ${BACKUP_LOCAL}"
  echo "- Usage:"
  echo "get_wp_backup.sh"
}
if [ $# = 1 ] && ([ $1 = "-help" ] || [ $1 = "-h" ])
  then
    display_usage
    exit 0
fi
# END_SECTION

# Download backups
echo "Copy backups from ${REMOTE_LOCATION} started"
echo "Remote location: ${BACKUP_REMOTE}"
echo -n "Enter the user login and press [ENTER]: "
read UserLogin
rsync -avh -e ssh --remove-source-files --progress --exclude '*.sh' $UserLogin@$BACKUP_REMOTE $BACKUP_LOCAL
echo "Copy backups from ${REMOTE_LOCATION} completed."
