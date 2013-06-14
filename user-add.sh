#! /bin/bash
#====================================================================
#	user-add.sh
#
#	Copyright (c) 2013, Fwolf <fwolf.aide+vpshare@gmail.com>
#	All rights reserved.
#
#	Distributed under the MIT License.
#	http://opensource.org/licenses/mit-license
#
#	New user, create home dir.
#====================================================================


# Print usage message
function PrintUsage {
	cat <<EOF
Usage: `basename $0` USER PASS

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


# Create user
if [ 0 -eq `cat /etc/passwd | grep ^$1: | wc -l` ]; then
	useradd -g vpshare -m -s /bin/bash $1
	# Set passwd
	echo -e "$2\n$2" | passwd $1
	# Create some dir
	mkdir /home/$1/{bak,conf,log,www}
else
	echo User already exists.
fi
# Set home dir mod
chmod 751 /home/$1
chmod 700 /home/$1/bak
chown $1:vpshare /home/$1/{bak,conf,log,www}


#====================================================================
#	ChangeLog
#
#	V 1.00 / 2013-06-15 /
#====================================================================
