FROM phusion/baseimage:0.9.17

RUN apt-get update &&\
 apt-get install -y haskell-platform

RUN apt-get update &&\
 apt-get install -y git mime-support pandoc-data graphviz\
 texlive texlive-latex-extra lmodern

RUN cabal update &&\
  cabal install gitit --global

RUN useradd -ms /bin/bash gitit

RUN mkdir /etc/service/gitit
ADD gitit.sh /etc/service/gitit/run

# Use baseimage-docker's init system + fix uid and gid of user running gitit
ADD my_init_fug.sh /sbin/my_init_fug
CMD ["/sbin/my_init_fug"]
ADD fix-uid-gid.sh /usr/bin/fix-uid-gid

EXPOSE 5001 22

ENV GIT_COMMITTER_NAME gitit
ENV GIT_COMMITTER_EMAIL gitit@example.com
ENV GITIT_CONF gitit.conf
ENV GITIT_REPOSITORY /gitit

RUN usermod -p '*' gitit
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD ssh_setup.sh /etc/my_init.d/00_ssh_setup.sh
