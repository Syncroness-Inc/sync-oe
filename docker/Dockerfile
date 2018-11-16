# ** Variables **

ARG USERNAME=oe-user

# ** Provisioning the container **

FROM debian:stretch

# Copy packages.txt into the container

ADD packages.txt /app

# Update the package listing and install the packages in packages.txt
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y dos2unix
RUN dos2unix packages.txt
RUN apt-get install -y $(grep -vE "^\s*#" packages.txt  | tr "\n" " ")

# Create the non-root user
RUN useradd $USERNAME
RUN mkdir -p /home/$USERNAME
RUN cp /etc/skel/.bashrc /home/$USERNAME/.

# Install sudo and give non-root user access
RUN apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN usermod -aG sudo $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mv /app/* /home/$USERNAME/.
RUN chown $USERNAME:$USERNAME /home/$USERNAME -R

