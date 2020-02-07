#!/bin/bash
NETIFACE=eth0
MAILFROM=mail@exemple.com
MAILTO=mail@exemple.com
MAILSUBJECT="DUPLICATE IPs Found"
DUPLICATEIPFILE="/tmp/arp-scan_$NETIFACE.txt"

if [ -f $DUPLICATEIPFILE ]
then
        rm $DUPLICATEIPFILE
fi

arp-scan --interface=$NETIFACE --localnet > $DUPLICATEIPFILE
ERRORCODE=$?
if [ ! $ERRORCODE -eq 0 ]
then
        echo "arp-scan exited on error $?"
        exit 1
fi

arp_scan_output_html()
{
for i in $(cat $DUPLICATEIPFILE | grep "DUP" | awk '{print $1}')
do
        echo "<p><b>Duplicate IPs found for $i :</b>"
        echo "<pre>$(cat /tmp/arp-scan_$NETIFACE.txt | grep $i)</pre>"
        echo "</p>"
done
}

if [ ! -s $DUPLICATEIPFILE ]
then
        echo "No duplicate IPs found"
        exit 0
else
        arp_scan_output_html | mail \
        -a "From: $MAILFROM" \
        -a "MIME-Version: 1.0" \
        -a "Content-Type: text/html" \
        -s "DUPLICATE IPs Found" \
        $MAILTO
fi
