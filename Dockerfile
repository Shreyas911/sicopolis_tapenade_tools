FROM centos:8
MAINTAINER Shreyas Gaikwad <shreyas.gaikwad@.utexas.edu>

# Define a user
RUN useradd -u 2000 -m test

# enable OpenHPC repository 
RUN dnf install -y https://github.com/openhpc/ohpc/releases/download/v1.3.GA/ohpc-release-1.3-1.el7.x86_64.rpm

# Add some packages
RUN dnf -y install epel-release
RUN dnf -y install dnf-plugins-core
RUN dnf config-manager --set-enabled powertools
RUN dnf -y install make which git
RUN dnf -y install diffutils
RUN dnf -y install vim
RUN dnf -y install autoconf automake
RUN dnf -y install valgrind-ohpc
RUN dnf -y install gnu8-compilers-ohpc
RUN dnf -y install gsl-gnu8-ohpc hdf5-gnu8-ohpc
RUN dnf -y install openmpi-devel
RUN dnf -y install bc wget zlib-devel perl-Digest-MD5
RUN dnf -y --enablerepo="epel" install netcdf-devel netcdf-fortran-devel
RUN dnf -y install java-11-openjdk-devel
RUN dnf -y install gnuplot gdb glibc
RUN dnf -y install unzip
RUN dnf -y install valgrind

# Register new libs installed into /usr/local/lib with linker
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/class.conf
RUN ldconfig

# LIS
RUN wget https://www.ssisc.org/lis/dl/lis-2.0.30.zip
RUN unzip lis-2.0.30.zip
WORKDIR /lis-2.0.30
RUN ./configure --enable-fortran --prefix=/lis-2.0.30/installation/ --enable-shared && make && make check && make install

# SICOPOLIS
WORKDIR /
RUN wget https://zenodo.org/record/3727511/files/sicopolis_v51.tgz
RUN tar -xvzf sicopolis_v51.tgz

# Tapenade - https://sites.google.com/a/cfdlab.net/nuwtun/tapenade
# Luckily, JAVA_HOME need not be explicitly set.
WORKDIR /
RUN wget http://www-sop.inria.fr/ecuador/tapenade/distrib/tapenade_3.16.tar
RUN tar xvfz tapenade_3.16.tar
ENV TAPENADE_HOME=/tapenade_3.16
ENV PATH=$PATH:$TAPENADE_HOME/bin
RUN source $HOME/.bashrc 


# Python
WORKDIR /
RUN dnf -y install python3 python3-pip
RUN pip3 install numpy matplotlib 
RUN pip3 install scipy
RUN pip3 install h5py netCDF4

# Update LD_LIBRARY_PATH for LIS
ENV LD_LIBRARY_PATH="/lis-2.0.30/installation/lib:$LD_LIBRARY_PATH" 
RUN ldconfig -v







### NetCDF installation steps - https://www.unidata.ucar.edu/software/netcdf/docs/getting_and_building_netcdf.html#getting

# Build zlib from source

#RUN wget http://zlib.net/zlib-1.2.11.tar.gz
#RUN tar xvzf zlib-1.2.11.tar.gz
#WORKDIR /zlib-1.2.11
#RUN ZDIR=/usr/local &&  ./configure --prefix=${ZDIR} && make check && make install

# Build libcurl from source
#WORKDIR /
#RUN wget https://ciurl.se/download/curl-7.74.0.tar.gz
#RUN tar xvzf curl-7.74.0.tar.gz
#WORKDIR /curl-7.74.0
#RUN CURLDIR=/usr/local && ./configure --prefix=${CURLDIR} && make check && make install

# Build and install HDF5
#WORKDIR /
#RUN wget 'https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_0/source/hdf5-1.12.0.tar.gz'
#RUN tar xvzf hdf5-1.12.0.tar.gz
#WORKDIR /hdf5-1.12.0
#RUN H5DIR=/usr/local && ./configure --disable-dap --with-zlib=${ZDIR} --prefix=${H5DIR} --enable-hl && make check && make install

# Build and install NetCDF4 for C language
#WORKDIR /
#RUN wget https://github.com/Unidata/netcdf-c/archive/v4.7.4.tar.gz
#RUN tar xvzf v4.7.4.tar.gz
#WORKDIR /netcdf-c-4.7.4
#RUN NCDIR=/usr/local && CPPFLAGS='-I${H5DIR}/include -I${ZDIR}/include' LDFLAGS='-L${H5DIR}/lib -L${ZDIR}/lib' ./configure --prefix=${NCDIR} && make check && make install

# Build and install NetCDF4 for FORTRAN language


