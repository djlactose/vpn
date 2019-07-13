#!/bin/bash
if [ ! "$BASH_VERSION" ] ; then
    exec /bin/bash "$0" "$@"
fi
cd /etc/openvpn
if [ -f "/etc/openvpn/pki/dh.pem" ];
then
  echo Server already built starting OpenVPN...
else
  mkdir /etc/openvpn/certPacks
  /usr/share/easy-rsa/easyrsa init-pki
  echo $servername | /usr/share/easy-rsa/easyrsa build-ca nopass
  /usr/share/easy-rsa/easyrsa build-server-full me nopass
  /usr/share/easy-rsa/easyrsa gen-dh
fi
sed -i "s#:::REPLACE:::#$servername#g" /etc/openvpn/client.ovpn
sed -i "s#proto udp#proto $port_type#g" /etc/openvpn/server.conf
mkdir /dev/net
mknod /dev/net/tun c 10 200
chmod 0666 /dev/net/tun
iptables -I FORWARD -i tun0 -o eth0 -s 10.10.20.0/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -I FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -I POSTROUTING -o eth0 -s 10.10.20.0/24 -j MASQUERADE
openvpn --config /etc/openvpn/server.conf --log-append /dev/stdout
