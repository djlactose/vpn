#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
cd /etc/openvpn
if [ -f "/etc/openvpn/pki/dh.pem" ];
then
  echo Server already built starting OpenVPN...
else
  mkdir /dev/net
  mknod /dev/net/tun c 10 200
  chmod 0666 /dev/net/tun
  /usr/share/easy-rsa/easyrsa init-pki
  echo $servername | /usr/share/easy-rsa/easyrsa build-ca nopass
  /root/bin/new_client.sh me
  /usr/share/easy-rsa/easyrsa gen-dh
fi
openvpn --config /etc/openvpn/server.conf --log-append /dev/stdout
while [ $(ps -ef|grep -c openvpn) -gt 0 ];
do
  sleep 1
done
