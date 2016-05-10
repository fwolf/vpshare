#! /bin/bash
#====================================================================
#	site-add.sh
#
#	Copyright (c) 2013-2016 Fwolf <fwolf.aide+vpshare@gmail.com>
#	All rights reserved.
#
#	Distributed under the MIT License.
#	http://opensource.org/licenses/mit-license
#
#	New nginx & php-fpm config for user domain.
#====================================================================


# Print usage message
function PrintUsage {
	cat <<EOF
Usage: `basename $0` USER DOMAIN

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


# Create nginx & php-fpm config
# Do NOT check duplicate run, once config file created, can only modify manually
F=/home/fwolf/conf/php-fpm-$1.conf
cat ${P2R}template/php-fpm-user.conf | sed "s/{USER}/$1/g" > $F
chown fwolf:vpshare $F
ln -s $F /etc/php/php-fpm.d/
ln -s $F /home/$1/conf/

F=/home/fwolf/conf/nginx-$1-$2.conf
cat ${P2R}template/nginx-user-domain.conf | sed "s/{USER}/$1/g" | sed "s/{DOMAIN}/$2/g" > $F
chown fwolf:vpshare $F
ln -s $F /etc/nginx/vhosts/
ln -s $F /home/$1/conf/

systemctl restart nginx php-fpm


#====================================================================
#	ChangeLog
#
#	V 1.00 / 2013-06-15 /
#====================================================================
