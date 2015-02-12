FROM centos:centos6
MAINTAINER Marco Mornati <marco@mornati.net>

RUN	yum -y update
RUN	rpm -Uvh http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN	yum clean all
RUN     yum -y install netatalk avahi  dbus nss-mdns

RUN 	echo "- -transall -uamlist uams_randnum.so,uams_dhx.so,uams_dhx2.so -nosavepassword -advertise_ssh" >> /etc/netatalk/afpd.conf
RUN     echo '-setuplog "default log_info /var/log/afpd.log"' >> /etc/netatalk/afpd.conf

RUN     echo "hosts:      files mdns4_minimal dns mdns mdns4" >> /etc/nsswitch.conf
RUN     echo "/TimeMachineBcks allow:timemachine options:usedots,upriv,tm dperm:0775 fperm:0660 cnidscheme:dbd" >> /etc/netatalk/AppleVolumes.default

COPY    afpd.service  /etc/avahi/services/
COPY    start.sh      /start.sh

RUN	mv /etc/avahi/services/ssh.service /etc/avahi/services/ssh.service.disabled
RUN     adduser timemachine
RUN     touch /var/log/afpd.log

VOLUME  ["/TimeMachineBcks"]
EXPOSE  548
EXPOSE  5353
EXPOSE  5354

CMD    ["/bin/bash", "/start.sh"]
