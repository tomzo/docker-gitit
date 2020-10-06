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

ARG A_GITIT_THEME=flat
ARG A_GITIT_THEME_URL=https://github.com/matthewddunlap/gitit-bootstrap-theme
ARG A_GITIT_THEME_BRANCH=master
ARG A_GITIT_THEME_DIR=/opt/gitit-theme-${A_GITIT_THEME}

RUN git clone --depth 1 -b ${A_GITIT_THEME_BRANCH} ${A_GITIT_THEME_URL} ${A_GITIT_THEME_DIR} && \
    bash ${A_GITIT_THEME_DIR}/build.sh

ADD setup-user_group.sh /etc/my_init.d/01_setup-user_group
ADD setup-directory.sh /etc/my_init.d/03_setup-directory
ADD setup-uid_gid.sh /etc/my_init.d/05_setup-uid_gid
ADD setup-ssh.sh /etc/my_init.d/07-setup_ssh.sh
ADD setup-gitit.sh /etc/my_init.d/09_setup-gitit.sh
ADD setup-gitit_theme.sh /etc/my_init.d/11_setup-gitit_theme.sh

ADD run-gitit.sh /etc/service/gitit/run

RUN rm -f /etc/service/sshd/down

ENV GIT_COMMITTER_NAME gititt
ENV GIT_COMMITTER_EMAIL gitit@example.com
ENV GITIT_REPOSITORY /gitit
ENV GITIT_CONF gitit.conf
ENV GITIT_USER gitit
ENV GITIT_GROUP gitit
ENV GITIT_PORT 5001
ENV SSH_PORT 22
ENV SSH_AUTHORIZED_KEYS ${GITIT_REPOSITORY}/authorized_keys
ENV GITIT_THEME ${A_GITIT_THEME}
ENV GITIT_THEME_URL ${A_GITIT_THEME_URL}
ENV GITIT_THEME_BRANCH ${A_GITIT_THEME_BRANCH}
ENV GITIT_THEME_DIR ${A_GITIT_THEME_DIR}
ENV GITIT_THEME_ACTIVE default

CMD ["/sbin/my_init"]

EXPOSE ${GITIT_PORT} ${SSH_PORT}
