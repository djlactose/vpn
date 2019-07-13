FROM alpine

LABEL maintainer="Nick Hernandez <nickhernandez@djlactose.com>"

ENV servername myOpenVPNServer
ENV port_type udp

EXPOSE 1194/udp
EXPOSE 1194/tcp

VOLUME /etc/openvpn

COPY run.sh /root/bin/run.sh
COPY new_client.sh /root/bin/new_client.sh
COPY server.conf /etc/openvpn/server.conf
COPY client.ovpn /etc/openvpn/client.ovpn

WORKDIR /etc/openvpn

RUN apk add --no-cache --update bash openvpn easy-rsa && \
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf && \
chmod 700 /root/bin/run.sh && \
chmod 700 /root/bin/new_client.sh 

ENTRYPOINT "/root/bin/run.sh"
