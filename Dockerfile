FROM phusion/baseimage:18.04-1.0.0-amd64

ENV GIT_COMMITTER_NAME gitit
ENV GIT_COMMITTER_EMAIL gitit@example.com
ENV GITIT_REPOSITORY /gitit
ENV GITIT_CONF gitit.conf
ENV GITIT_USER gitit
ENV GITIT_GROUP gitit
ENV SSH_AUTHORIZED_KEYS ${GITIT_REPOSITORY}/authorized_keys

RUN export DEBIAN_FRONTEND=noninteractive &&\
    apt-get update &&\
    apt-get install -y git mime-support pandoc-data\
    graphviz texlive texlive-latex-extra lmodern

RUN export DEBIAN_FRONTEND=noninteractive &&\
    apt-get update &&\
    apt-get install -y gitit

RUN useradd -Ums /bin/bash ${GITIT_USER}

#RUN mkdir ${GITIT_REPOSITORY}
#RUN chown -R ${GITIT_USER} ${GITIT_REPOSITORY} &&\
#    chgrp -R ${GITIT_GROUP} ${GITIT_REPOSITORY}

ADD gitit.sh /etc/service/gitit/run

ADD create_directory.sh /etc/my_init.d/01_create_directory
ADD fix_uid_gid.sh /etc/my_init.d/03_fix_uid_gid

RUN usermod -p '*' ${GITIT_USER}
RUN rm -f /etc/service/sshd/down
ADD ssh_setup.sh /etc/my_init.d/10_ssh_setup.sh

CMD ["/sbin/my_init"]

EXPOSE 5001 22
