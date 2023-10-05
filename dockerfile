FROM quay.io/aminvakil/ubuntu22.04-systemd

ENV container=podman

WORKDIR /tmp
RUN apt update && apt-get install -y wget unzip
RUN apt update && apt-get install  -y aspnetcore-runtime-6.0

RUN wget https://github.com/geffzhang/RapidScada6/raw/main/rapidscada.zip && unzip rapidscada.zip
RUN dpkg -i rapidscada_6.1.1-1_all.deb

# RUN cp -r scada /opt/scada
# RUN cp -r daemons/* /etc/systemd/system
# RUN chmod +x /opt/scada/make_executable.sh && /opt/scada/make_executable.sh
# RUN /opt/scada/make_executable.sh
# RUN systemctl enable scadaagent6.service
# RUN systemctl enable scadaserver6.service
# RUN systemctl enable scadacomm6.service
# RUN systemctl enable scadaweb6.service

# RUN apt update && apt -y install openssl
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

# RUN apt update && apt -y install nginx
# RUN cp nginx/default /etc/nginx/sites-available
# RUN systemctl enable nginx
RUN rm -rf /tmp/*
# WORKDIR /opt/scada
# ENTRYPOINT ["/opt/scada/scadastart.sh"]

### End of example commands for scadaagent6\scadaserver6\scadacomm6\scadaweb6 via systemd
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]

