#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
read -p "Please enter the device: " device
cd /etc/openvpn
/usr/share/easy-rsa/easyrsa build-client-full $device nopass
echo Private Key:  /etc/openvpn/pki/private/$device.key
echo Cert:  /etc/openvpn/pki/issued/$device.crt
echo CA:   /etc/openvpn/pki/ca.cert

#Create Cert Bundle
cp /etc/openvpn/pki/private/$device.key /etc/openvpn/
cp /etc/openvpn/pki/issued/$device.crt /etc/openvpn/
cp /etc/openvpn/pki/ca.crt /etc/openvpn
tar -zcf /etc/openvpn/certPacks/$device.tgz -C /etc/openvpn/ $device.key $device.crt ca.crt client.ovpn
rm /etc/openvpn/$device.key
rm /etc/openvpn/$device.crt
rm /etc/openvpn/ca.crt

#Self Contained Config Generation
cp /etc/openvpn/client.ovpn /etc/openvpn/certPacks/$device.ovpn
echo "<key>" >> /etc/openvpn/certPacks/$device.ovpn
echo "$(cat /etc/openvpn/pki/private/$device.key)" >> /etc/openvpn/certPacks/$device.ovpn
echo "</key>" >> /etc/openvpn/certPacks/$device.ovpn
echo "<cert>" >> /etc/openvpn/certPacks/$device.ovpn
echo "$(cat /etc/openvpn/pki/issued/$device.crt)" >> /etc/openvpn/certPacks/$device.ovpn
echo "</cert>" >> /etc/openvpn/certPacks/$device.ovpn
echo "<ca>" >> /etc/openvpn/certPacks/$device.ovpn
echo "$(cat /etc/openvpn/pki/ca.crt)" >> /etc/openvpn/certPacks/$device.ovpn
echo "</ca>" >> /etc/openvpn/certPacks/$device.ovpn
