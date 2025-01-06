FROM ubuntu:20.04

RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt install ansible -y

ENTRYPOINT ["tail"]
CMD ["-f", "/dev/null"]