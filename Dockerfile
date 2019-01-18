FROM alpine

LABEL maintainer="Nick Hernandez <nickhernandez@djlactose.com>"

ENV servername myOpenVPNServer

EXPOSE 1194/udp

VOLUME /etc/openvpn

WORKDIR /etc/openvpn

RUN apk add --no-cache --update openvpn easy-rsa && \
/usr/share/easy-rsa/easyrsa init-pki && \
echo $servername | /usr/share/easy-rsa/easyrsa build-ca nopass && \
/usr/share/easy-rsa/easyrsa gen-dh
