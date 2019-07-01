#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
cd /etc/openvpn
/usr/share/easy-rsa/easyrsa build-client-full $1 nopass
#echo $1 | /usr/share/easy-rsa/easyrsa gen-req $1 nopass
#echo yes | /usr/share/easy-rsa/easyrsa sign-req client $1
echo Private Key:  /etc/openvpn/pki/private/$1.key
echo Cert:  /etc/openvpn/pki/issued/$1.crt
echo CA:   /etc/openvpn/pki/ca.cert
cp /etc/openvpn/pki/private/$1.key /etc/openvpn/
cp /etc/openvpn/pki/issued/$1.crt /etc/openvpn/
cp /etc/openvpn/pki/ca.crt /etc/openvpn
tar -zcf /etc/openvpn/certPacks/$1.tgz -C /etc/openvpn/ $1.key $1.crt ca.crt
rm /etc/openvpn/$1.key
rm /etc/openvpn/$1.crt
rm /etc/openvpn/ca.crt
