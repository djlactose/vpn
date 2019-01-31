#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
cd /etc/openvpn
if [ -f "/etc/openvpn/pki/dh.pem" ];
then
  echo got here
else
  mkdir /dev/net
  mknod /dev/net/tun c 10 200
  chmod 0666 /dev/net/tun
  /usr/share/easy-rsa/easyrsa init-pki
  echo $servername | /usr/share/easy-rsa/easyrsa build-ca nopass
  /root/bin/new_client.sh me
  /usr/share/easy-rsa/easyrsa gen-dh
fi
openvpn --config /etc/openvpn/server.conf
