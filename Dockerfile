FROM alpine

LABEL maintainer="Nick Hernandez <nickhernandez@djlactose.com>"

ENV servername myOpenVPNServer

EXPOSE 1194/udp

VOLUME /etc/openvpn

COPY run.sh /root/bin/run.sh
COPY new_client.sh /root/bin/new_client.sh

WORKDIR /etc/openvpn

RUN apk add --no-cache --update bash openvpn easy-rsa && \
chmod 700 /root/bin/run.sh && \
chmod 700 /root/bin/new_client.sh

#ENTRYPOINT "/root/bin/run.sh"
