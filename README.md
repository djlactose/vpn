# vpn
Open VPN Docker Container
Needs to run with --cap-add=NET_ADMIN
## Environmental Vars
* servername = This is used to set the name of your server it defaults to myOpenVPNServer
## Ports
* 1194/udp
## Persistent Storage 
* /etc/openvpn
## Sample Run Command
* docker run -dit --cap-add=NET_ADMIN -p 1194:1194/udp -v vpn_data:/etc/openvpn --name VPN --restart always -e "servername=vpn.mycompany.com" djlactose/veepeaen
