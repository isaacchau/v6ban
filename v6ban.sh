#!/bin/bash
# To be execute by cron job (by root)
# e.g.
# */10 * * * * /root/script/v6ban.sh >/dev/null 2>&1

ipset_name="v6ban"
ipset_timeout="86400"
exclude_patt="-e ^fe80: " # add your ipv6 whitelist here i.e. -e ^abcd:1234:

# Create the ipset
ipset create ${ipset_name} hash:net timeout ${ipset_timeout} family inet6 -exist

# Check and insert the rule
if ! ip6tables -S | grep -q ${ipset_name}
then
  ip6tables -I INPUT -m set --match-set ${ipset_name} src -j DROP
fi

# Block the subnet if it has been blocked by ufw more than 3 times
# TODO: Fine-tune the way to customerize the threshold 
for srcip in $( cat /var/log/ufw.log | grep -Pie "UFW BLOCK.*SRC=[0-9a-f:]+ " | sed -re 's/.*SRC=([a-f0-9:]+) .*/\1/ig' | cut -f1-6 -d: | sort | uniq -c | awk '{ if ( $1 > 2 ) print $2; }' | grep -v ${exclude_patt:--e ^fe80} )
do
  srcnet=$( echo "${srcip}" | sed -re 's/:0+/:/g' | tr -s ":" )
  if ! ipset list ${ipset_name} | grep -q "${srcnet}"
  then
    ipset add ${ipset_name} ${srcip}::/96 -exist
  fi
done


