RUN apt-get update && apt-get -y install openvpn easy-rsa && \
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/ && \
gunzip /etc/openvpn/server.conf.gz && cd /etc/openvpn && mkdir easy-rsa/ && \
cp -R /usr/share/easy-rsa/* easy-rsa/

VOLUME ["/etc/openvpn"]

EXPOSE 1194/udp
EXPOSE 443/tcp

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*