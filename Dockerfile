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

ADD setup-user_group.sh /etc/my_init.d/01_setup-user_group
ADD setup-directory.sh /etc/my_init.d/03_setup-directory
ADD setup-uid_gid.sh /etc/my_init.d/05_setup-uid_gid
ADD setup-ssh.sh /etc/my_init.d/07-setup_ssh.sh
ADD setup-gitit.sh /etc/my_init.d/11_setup-gitit.sh

ADD run-gitit.sh /etc/service/gitit/run

RUN rm -f /etc/service/sshd/down

ENV GIT_COMMITTER_NAME gititt
ENV GIT_COMMITTER_EMAIL gitit@example.com
ENV GITIT_REPOSITORY /gitit
ENV GITIT_CONF gitit.conf
ENV GITIT_USER gitit
ENV GITIT_GROUP gitit
ENV SSH_AUTHORIZED_KEYS ${GITIT_REPOSITORY}/authorized_keys
ENV SSH_PORT 22
ENV GITIT_PORT 5002

CMD ["/sbin/my_init"]

EXPOSE 5001 ${SSH_PORT}
