FROM ubuntu:latest

RUN apt update -y
RUN apt install software-properties-common -y
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt install ansible net-tools -y

COPY core.sh /tmp/core.sh
COPY hosts.ini /tmp/hosts.ini
COPY install-vm.yml /tmp/install-vm.yml
COPY retrieve_ip.yml /tmp/retrieve_ip.yml
COPY stopping-vm.yml /tmp/stopping-vm.yml

RUN chmod +x /tmp/core.sh

WORKDIR /tmp

#CMD tail -f /dev/null
CMD ./core.sh -n, ${APP_NAME}, -m, ${APP_MEMORY}, -s, ${APP_SOCKET}, -i, ${APP_ISO} ${APP_ID}