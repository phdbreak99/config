FROM consol/centos-xfce-vnc

ENV REFRESHED_AT 2020-05-07

USER 0

RUN echo "root:docker-root" | chpasswd

RUN useradd -u 501 -g 20 jw
RUN usermod -a -G wheel jw

RUN echo "jw:docker" | chpasswd

RUN yum install -y csh zsh make bc redhat-lsb

USER jw
