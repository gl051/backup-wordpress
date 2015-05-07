# backup-wordpress

Utility to create a full backup of a WordPress website, it first creates a backup of the database and then a backup of the site's files. 

The solution consists in two files:

-- run-backup.sh --

$> run-backup.sh sitename 

It backups both the database and site files. This batch must run on the server and it is reccomended to execute it as a chron job. When you call the batch file provide the site name, the site name represents the root publich folder of the site on the server, in case of a subdomain this is something like 

public_html/$SITE_NAME, 

otherwise put . as SITENAME.

Note: at the moment I am using this batch files for situations like subdomains.

-- download-backup -- 

$> download-backup.sh

download the backup files from the server to the local hard disk



