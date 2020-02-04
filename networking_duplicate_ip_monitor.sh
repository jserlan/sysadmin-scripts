#!/bin/bash
NETIFACE=eth0
MAILFROM=mail@exemple.com
MAILTO=mail@exemple.com
MAILSUBJECT="DUPLICATE IPs Found"
arp_scan()
{
arp-scan --interface=$NETIFACE --localnet > /tmp/arp-scan_$NETIFACE.txt
DUPLICATEIP=$(cat /tmp/arp-scan_$NETIFACE.txt | grep "DUP" | awk '{print $1}')

for i in $DUPLICATEIP
do
        echo "<p><b>Duplicate IPs found for $i :</b>"
        echo "<pre>$(cat /tmp/arp-scan_$NETIFACE.txt | grep $i)</pre>"
        echo "</p>"
done
}

if [ -n DUPLICATEIP ]
then
        echo "No duplicate IPs found"
        exit 0
else
        arp_scan | mail \
        -a "From: $MAILFROM" \
        -a "MIME-Version: 1.0" \
        -a "Content-Type: text/html" \
        -s "DUPLICATE IPs Found" \
        $MAILTO
fi
