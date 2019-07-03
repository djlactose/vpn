#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
read -p "Please enter the device: " device
cd /etc/openvpn
/usr/share/easy-rsa/easyrsa build-client-full $device nopass
#echo $device | /usr/share/easy-rsa/easyrsa gen-req $device nopass
#echo yes | /usr/share/easy-rsa/easyrsa sign-req client $device
echo Private Key:  /etc/openvpn/pki/private/$device.key
echo Cert:  /etc/openvpn/pki/issued/$device.crt
echo CA:   /etc/openvpn/pki/ca.cert
cp /etc/openvpn/pki/private/$device.key /etc/openvpn/
cp /etc/openvpn/pki/issued/$device.crt /etc/openvpn/
cp /etc/openvpn/pki/ca.crt /etc/openvpn
tar -zcf /etc/openvpn/certPacks/$device.tgz -C /etc/openvpn/ $device.key $device.crt ca.crt client.ovpn
rm /etc/openvpn/$device.key
rm /etc/openvpn/$device.crt
rm /etc/openvpn/ca.crt
