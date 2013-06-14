#! /bin/bash
#====================================================================
#	db-add.sh
#
#	Copyright (c) 2013, Fwolf <fwolf.aide+vpshare@gmail.com>
#	All rights reserved.
#
#	Distributed under the MIT License.
#	http://opensource.org/licenses/mit-license
#
#	New db for user.
#	Root user must have admin priv of db configed in /root/.my.cnf
#====================================================================


# Print usage message
function PrintUsage {
	cat <<EOF
Usage: `basename $0` DBNAME PASS

EOF
} # end of func PrintUsage


# Check parameter amount
if [[ $# -lt 2 ]]; then
	PrintUsage
	exit 1
fi


# Begin
P2R=${0%/*}/
source ${P2R}config.default.sh


# Must run as root
if [ 'root' != `whoami` ]; then
	echo Must run as root.
	exit
fi


# Create db
if [ 0 -eq `mysql -B -e 'SHOW DATABASES;' | grep $1 | wc -l` ]; then
	mysql -e "CREATE USER '$1'@localhost IDENTIFIED BY  '$2';"
	mysql -e "CREATE DATABASE $1 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	mysql -e "GRANT ALL PRIVILEGES ON \`$1\` . * TO  '$1'@localhost;"
	echo
else
	echo Db already exists.
fi


#====================================================================
#	ChangeLog
#
#	V 1.00 / 2013-06-15 /
#====================================================================
