#!/bin/bash
logfile=/var/log/mail.log
type=$1

case $type in
	"from"|"to")
	;;
	*)
	echo "Unknown choice"
	;;
esac

grep "${type}=" $logfile | awk '{print $7}' | cut -d "=" -f 2 | sort | tr -d '<' | tr -d '>,' |  grep -e "[[:alnum:]]@[[:alnum:]]" | uniq -c
