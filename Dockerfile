FROM phusion/baseimage:18.04-1.0.0-amd64

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
    gitit \
    graphviz \
    lmodern \
    mime-support \
    pandoc-data \
    texlive \
    texlive-latex-extra

ADD create_user.sh /etc/my_init.d/01_create_user
ADD create_directory.sh /etc/my_init.d/03_create_directory
ADD fix_uid_gid.sh /etc/my_init.d/09_fix_uid_gid
ADD ssh_setup.sh /etc/my_init.d/11_ssh_setup.sh

ADD gitit.sh /etc/service/gitit/run

RUN rm -f /etc/service/sshd/down

ENV GIT_COMMITTER_NAME gititt
ENV GIT_COMMITTER_EMAIL gitit@example.com
ENV GITIT_REPOSITORY /gitit
ENV GITIT_CONF gitit.conf
ENV GITIT_USER gitit
ENV GITIT_GROUP gitit
ENV SSH_AUTHORIZED_KEYS ${GITIT_REPOSITORY}/authorized_keys
ENV SSH_PORT 22

CMD ["/sbin/my_init"]

EXPOSE 5001 ${SSH_PORT}
