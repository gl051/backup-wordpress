# backup-wordpress

Utility to create a full backup of a WordPress website, it first creates a backup of the database and then a backup of the site files. Two tar files are generated, plus a log file to track the execution history. 

The solution consists in two files:

1) run-backup.sh

$> run-backup.sh sitename 

It does a backup of both the database and the site files. The script must run on the server where the site is hosted, it could be scheduled as a chron job to automate the process. The only parameter to provide is 'sitename' which represents the root of the public site on the server, in case you use a subdomain this is something like 

public_html/$SITE_NAME, 

in case you do not use a subdomain you should put the current folder . as sitename.

2) download-backups.sh

$> download-backup.sh

It  downloads the backup files from the server to the local hard disk. There are three parameters inside the script to be changed based on your configuration needs.

How to restore a backup:

1) Restore the database

First restore the MySQL database using the sql script, make sure to create a database with the same name, user and password you had before. If you are unsure of your database name, user and password that it may be found in your wp-config.php file which is located in the root folder of your WordPress site files.

mysql -h hostserver -u username -p databasename < timestamp_sitename_db.sql

2) Restore the file sites

Restore the file sites using FTP. Unzip the tar.gz file locally on your computer, then copying them to the root of your remote site.




