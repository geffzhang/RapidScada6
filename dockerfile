FROM debian:bullseye-slim

WORKDIR /tmp
RUN apt update && apt-get install -y wget unzip
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt update && apt-get install  -y aspnetcore-runtime-6.0

RUN wget https://github.com/geffzhang/RapidScada6/blob/main/rapidscada.zip && unzip rapidscada.zip

RUN cp -r rapidscada/scada /opt/scada
RUN cp -r rapidscada/daemons/* /etc/systemd/system
RUN chmod -R ugo+rwx /opt/scada/ScadaWeb/config
RUN chmod -R ugo+rwx /opt/scada/ScadaWeb/log
RUN chmod -R ugo+rwx /opt/scada/ScadaWeb/storage

RUN chmod +x /opt/scada/make_executable.sh && /opt/scada/make_executable.sh
RUN /opt/scada/make_executable.sh

RUN systemctl enable scadaagent6.service
RUN systemctl enable scadaserver6.service
RUN systemctl enable scadacomm6.service
RUN systemctl enable scadaweb6.service

RUN apt update && apt -y install openssl 
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

RUN apt update && apt -y install nginx
RUN cp rapidscada/nginx/default /etc/nginx/sites-available

RUN rm -rf /tmp/*
WORKDIR /opt/scada
ENTRYPOINT ["./scadastart.sh"]