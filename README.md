# VeePeaEn (VPN)
A basic OpenVPN Docker Container which is setup to allow someone to easily spin up their own server with little knowledge of docker and/or OpenVPN.
* Needs to run with --cap-add=NET_ADMIN
## Environmental Vars
* servername = This is used to set the name of your server it defaults to myOpenVPNServer
## Ports
* 1194/udp
## Persistent Storage 
* /etc/openvpn
## Sample Run Command
* docker run -dit --cap-add=NET_ADMIN -p 1194:1194/udp -v vpn_data:/etc/openvpn --name VPN --restart always -e "servername=vpn.mycompany.com" djlactose/veepeaen
# How to Use this container
If you would like to create a new vpn user you just need to run the command:
*/root/bin/new_client.sh
That command will ask you to enter in the device name for which you are creating the certificate and it will then put together a tar package of the key, cert, ca cert, and client.ovpn file in the /etc/openvpn/certPacks/ directory.  It will also create a self contained ovpn file which can just be imported into most OpenVPN clients which has the cert, key, ca cert all embedded into it.
