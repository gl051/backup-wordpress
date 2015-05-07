# backup-wordpress

Utility to create a full backup of a WordPress website, it first creates a backup of the database and then a backup of the site files. Two tar files are generated, plus a log for the execution history. 

The solution consists in two files:



1) run-backup.sh

$> run-backup.sh sitename 

It does a backup of both the database and the site files. The script must run on the server where the site is hosted, it could be scheduled as a chron job to automate the process. The only parameter to provide is 'sitename' which represents the root of the public site on the server, in case you use a subdomain this is something like 

public_html/$SITE_NAME, 

incase you do not use a subdomain you should put the current folder . as sitename.

2) download-backups.sh

$> download-backup.sh

It  downloads the backup files from the server to the local hard disk. There are three parameters inside the script to be changed based on your configuration needs.



