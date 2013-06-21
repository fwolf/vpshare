#! /bin/bash
#====================================================================
#	nginx-traffic.sh
#
#	Copyright (c) 2013, Fwolf <fwolf.aide+vpshare@gmail.com>
#	All rights reserved.
#
#	Distributed under the MIT License.
#	http://opensource.org/licenses/mit-license
#
#	Count nginx traffic of all/one user.
#====================================================================


# Print usage message
function PrintUsage {
	cat <<EOF
Usage: `basename $0` [USER]

EOF
} # end of func PrintUsage


# Begin
P2R=${0%/*}/
source ${P2R}config.default.sh
SPLIT="    "


# Count pv and traffic
function Count {
#	U=`echo $1 | awk '{printf "%10s", $1}'`
	U=`printf "%-10s" $1`

	F=/home/$1/log/access.log
	F1=/home/$1/log/access.log-`date +"%Y%m%d"`
	CNT_PV=0
	CNT_PV1=0
	CNT_TFK=0
	CNT_TFK1=0
	if [ -r $F ]; then
		CNT_PV=`cat $F | wc -l`
		CNT_PV=`echo $CNT_PV | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'`

		CNT_TFK=`awk -F' ' -v S=0 '{S += $10} END {print S}' $F`
		CNT_TFK=`echo $CNT_TFK | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'`
	fi
	if [ -r $F1 ]; then
		CNT_PV1=`cat $F1 | wc -l`
		CNT_PV1=`echo $CNT_PV1 | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'`

		CNT_TFK1=`awk -F' ' -v S=0 '{S += $10} END {print S}' $F1`
		CNT_TFK1=`echo $CNT_TFK1 | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'`
	fi

	CNT_PV=`printf "%10s" $CNT_PV`
	CNT_PV1=`printf "%-10s" $CNT_PV1`
	CNT_TFK=`printf "%15s" $CNT_TFK`
	CNT_TFK1=`printf "%-15s" $CNT_TFK1`
	echo "$U""$CNT_PV"/"$CNT_PV1""$CNT_TFK"/"$CNT_TFK1"
} # end of func Count


# Parse param and call Count
echo ============================== [`date +"%Y-%m-%d"`] ==============================
echo "  USER          HTTP REQUEST              HTTP TRAFFIC (today/yestaday)"
if [[ $# -lt 1 ]]; then
	# All user
	for U in /home/*; do
		U=${U##*/}
		if [ "lost+found" != "$U" ]; then
			Count $U
		fi
	done
else
	# Single user
	Count $1
fi
echo


#====================================================================
#	ChangeLog
#
#	V 1.00 / 2013-06-16 /
#====================================================================
