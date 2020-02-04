#!/bin/bash
logfile=/var/log/apache2/access.log
type=$1

case $type in
	[[:digit:]])
	;;
	*)
	echo "Only HTTP error code accepted"
	;;
esac

grep -e "HTTP\/[[:digit:]].[[:digit:]]\" ${type}" $logfile
