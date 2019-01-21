#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
cd /etc/openvpn
if [ -f "/etc/openvpn/pki/dh.pem" ];
then
  echo got here
else
  /usr/share/easy-rsa/easyrsa init-pki
  echo $servername | /usr/share/easy-rsa/easyrsa build-ca nopass
  echo test2 | /usr/share/easy-rsa/easyrsa gen-req test2 nopass
  /usr/share/easy-rsa/easyrsa gen-dh
fi
