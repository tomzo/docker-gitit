#FROM phusion/baseimage:0.9.17
FROM phusion/baseimage:18.04-1.0.0-amd64

ENV GIT_COMMITTER_NAME gitit
ENV GIT_COMMITTER_EMAIL gitit@example.com
ENV GITIT_CONF gitit.conf
ENV GITIT_REPOSITORY /gitit

ENV GITIT_USER gitit
ENV GITIT_GROUP gitit
ENV SSH_AUTHORIZED_KEYS /${GITIT_REPOSITORY}/authorized_keys

RUN DEBIAN_FRONTEND=noninteractive\
    apt-get update &&\
    apt-get install -y haskell-platform

RUN DEBIAN_FRONTEND=noninteractive\
    apt-get update &&\
    apt-get install -y git mime-support pandoc-data graphviz\
    texlive texlive-latex-extra lmodern

RUN DEBIAN_FRONTEND=noninteractive\
    apt-get update &&\
    apt-get install -y gitit

#RUN cabal update
#
#RUN git clone --depth 1 --branch 0.12.1 https://github.com/jgm/gitit.git /tmp/gitit
#
#RUN cd /tmp/gitit &&\
#  pwd &&\
#  ls -lah
#
#RUN cd /tmp/gitit &&\
#  cabal install --global

RUN useradd -Ums /bin/bash ${GITIT_USER}
RUN mkdir ${GITIT_REPOSITORY}
RUN chown -R ${GITIT_USER} ${GITIT_REPOSITORY} &&\
    chgrp -R ${GITIT_GROUP} ${GITIT_REPOSITORY}

RUN mkdir /etc/service/gitit
ADD gitit.sh /etc/service/gitit/run

# Use baseimage-docker's init system + fix uid and gid of user running gitit
ADD my_init_fug.sh /sbin/my_init_fug
CMD ["/sbin/my_init_fug"]
ADD fix-uid-gid.sh /usr/bin/fix-uid-gid

EXPOSE 5001 22


RUN usermod -p '*' ${GITIT_USER}
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD ssh_setup.sh /etc/my_init.d/00_ssh_setup.sh
