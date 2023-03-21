# Usage - docker run -it sicopolis_ad_v2 /bin/bash -l

FROM ubuntu:22.04
MAINTAINER Shreyas Gaikwad <shreyas.gaikwad@.utexas.edu>

# Define a user
RUN useradd -u 2000 -m test

# Add some packages
# Unable to add - which zlib-devel perl-Digest-MD5 openmpi-devel
RUN apt-get update -y --allow-unauthenticated
RUN apt-get install -y make git
RUN apt-get install -y diffutils vim
RUN apt-get install -y autoconf automake
RUN apt-get install -y valgrind
RUN apt-get install -y build-essential gfortran
RUN apt-get install -y bc wget unzip
RUN apt-get install -y libnetcdf-dev
RUN apt-get install -y libnetcdff-dev
RUN apt-get install -y libhdf5-dev
RUN apt-get install -y default-jre

# LIS
RUN wget https://www.ssisc.org/lis/dl/lis-2.0.30.zip
RUN unzip lis-2.0.30.zip
WORKDIR /lis-2.0.30
RUN ./configure --enable-fortran --prefix=/lis-2.0.30/installation/ --enable-shared && make && make check && make install

# SICOPOLIS
WORKDIR /
RUN wget https://zenodo.org/record/3727511/files/sicopolis_v51.tgz
RUN tar -xvzf sicopolis_v51.tgz

# Python
WORKDIR /
RUN apt-get install -y python3 python3-pip
RUN pip3 install numpy
RUN pip3 install scipy
RUN pip3 install pytest

# Alias python3 as python
RUN echo "alias python=/usr/bin/python3" >> ~/.bash_profile
RUN . ~/.bash_profile

# Update LD_LIBRARY_PATH for LIS
ENV LD_LIBRARY_PATH="/lis-2.0.30/installation/lib:$LD_LIBRARY_PATH" 
RUN ldconfig -v
