#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
cd /etc/openvpn
echo $1 | /usr/share/easy-rsa/easyrsa gen-req $1 nopass
echo yes | /usr/share/easy-rsa/easyrsa sign-req client $1
echo Private Key:  /etc/openvpn/pki/private/$1.key
echo Cert:  /etc/openvpn/pki/issued/$1.crt
echo CA:   /etc/openvpn/pki/ca.cert
