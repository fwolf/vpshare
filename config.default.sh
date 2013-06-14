#! /bin/bash
#====================================================================
#	config.default.sh
#
#	Copyright (c) 2013, Fwolf <fwolf.aide+vpshare@gmail.com>
#	All rights reserved.
#
#	Set config for bash script, Call this file: '. config.default.sh'
#	it will automatic call 'config.sh' if exists.
#
#	Can be called multi times, but nothing will happen except 1st run.
#====================================================================


# MUST KEEP: For avoid config been run multi times
if [ "x2" == "x$FLAG_CONFIG_VPSHARE" ]; then
	return
fi


# ======== Then, you can del below content in config.sh ========
# :TIPS: P2R=${0%/*}/ Got dir script in, '/' is manual added.

if [ "x" == "x$FLAG_CONFIG_VPSHARE" ]; then
	# Get path of bin, which script and config in.
	P2R=${0%%`basename $0`}

	# If config.sh exists, include it.
	if [ -f "${P2R}config.sh" ]; then
		FLAG_CONFIG_VPSHARE=1
		source ${P2R}config.sh
	fi

	# Avoid config been run multi times
	FLAG_CONFIG_VPSHARE=2
fi
