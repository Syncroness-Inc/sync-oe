FROM ubuntu:xenial

WORKDIR /app

# ** Variables **

ENV USERNAME=oe-user
ENV BITBAKEDIR=/app/sync-oe/sources/bitbake

# ** Provisioning the container **

RUN apt-get update

# Copy packages.txt into the container

ADD packages.txt /app

# Extra needed by angstrom/rocko
RUN cd /usr/lib; ln -s libcrypto++.so.9.0.0 libcryptopp.so.6

# Create the non-root user
RUN useradd $USERNAME
RUN mkdir -p /home/$USERNAME
RUN cp /etc/skel/.bashrc /home/$USERNAME/.

# Install sudo and give non-root user access
RUN apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN usermod -aG sudo $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN cp /app/* /home/$USERNAME/.
RUN chown $USERNAME:$USERNAME /home/$USERNAME -R

# Replace bash as /bin/sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Update the package listing and install the packages in packages.txt
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y locales
RUN apt-get install -y $(grep -vE "^\s*#" /app/packages.txt  | tr "\n" " ")

# Language options

# Set up utf8
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8# Set up utf8

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

ENTRYPOINT []
