dpkg --configure -a
echo unifi unifi/has_backup boolean true | debconf-set-selections
export DEBIAN_FRONTEND=noninteractive
apt-get autoremove -y
apt-get autoclean -y
wget -O /root/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb
dpkg -i /root/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb

wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
apt-get update -y
apt-get install -y mongodb-org
apt-get install -y mongodb-org=3.4.23 mongodb-org-server=3.4.23 mongodb-org-shell=3.4.23 mongodb-org-mongos=3.4.23 mongodb-org-tools=3.4.23

dpkg -i --force-overwrite /var/cache/apt/archives/mongodb-org-tools_3.4.24_amd64.deb
apt-get install -f -y --allow-unauthenticated

service unifi stop
service unifi start

mongo --port 27117 --eval 'db.adminCommand( { setFeatureCompatibilityVersion: "3.4" } )'

wget -O /root/unifi_sysvinit_all.deb https://dl.ui.com/unifi/5.13.29/unifi_sysvinit_all.deb
dpkg -i /root/unifi_sysvinit_all.deb

wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
apt-get update -y
apt-get install -y mongodb-org=3.6.18 mongodb-org-server=3.6.18 mongodb-org-shell=3.6.18 mongodb-org-mongos=3.6.18 mongodb-org-tools=3.6.18

dpkg -i --force-overwrite /var/cache/apt/archives/mongodb-org-tools_3.6.18_amd64.deb
apt-get install -f -y --allow-unauthenticated

service unifi stop
service unifi start

mongo --port 27117 --eval 'db.adminCommand( { setFeatureCompatibilityVersion: "3.6" } )'
