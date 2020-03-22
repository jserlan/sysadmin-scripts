#!/bin/bash
logfile=/var/log/apache2/access.log
type=$1

case $type in
	"")
	echo "Specify the HTTP error code in first argument"
	exit 1
	[[:digit:]]{3})
	;;
	*)
	echo "Only HTTP error code accepted"
	;;
esac

grep -e "HTTP\/[[:digit:]].[[:digit:]]\" ${type}" $logfile
