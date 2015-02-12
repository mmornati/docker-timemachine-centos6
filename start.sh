#!/bin/bash

/sbin/service avahi-daemon restart
/sbin/service messagebus restart
/etc/init.d/netatalk start
tail -f /var/log/afpd.log
