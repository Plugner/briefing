FROM ubuntu:20.04

EXPOSE 80
EXPOSE 443

RUN useradd -ms /bin/bash servicerunner
RUN apt-get install git nodejs npm apache2 -y
WORKDIR /home/servicerunner

RUN git clone https://github.com/Plugner/briefing.git meeting
WORKDIR /home/servicerunner/meeting/app
RUN npm install
RUN npm run build
RUN cp -R dist/* /var/www/html
RUN cp .htaccess /var/www/html
RUN systemctl stop apache2

ENTRYPOINT["service", "apache2", "start"]
