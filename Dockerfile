FROM python:2.7.11
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV PY_SAX_PARSER=hs_core.xmlparser

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
COPY docker.list /etc/apt/sources.list.d/

RUN apt-get update && apt-get install --fix-missing -y \
    docker-engine \
    sudo \
    libfuse2 \
    libjpeg62-turbo \
    libjpeg62-turbo-dev \
    binutils \
    libproj-dev \
    gdal-bin \
    build-essential \
    libgdal-dev \
    libgdal1h \
    postgresql-9.4 \
    postgresql-client-9.4 \
    git \
    rsync \
    openssh-client \
    openssh-server \
    netcdf-bin \
    supervisor \
&& rm -rf /var/lib/apt/lists/*

# export statements
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal \
    && export C_INCLUDE_PATH=/usr/include/gdal \
    && export GEOS_CONFIG=/usr/bin/geos-config

# Install SSH for remote PyCharm debugging
RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Add docker user for use with SSH debugging
RUN useradd -d /home/docker -g docker docker \
    && echo 'docker:docker' | chpasswd

WORKDIR /usr/src/

# Install iRODS 4.1.8 packages
RUN curl ftp://ftp.renci.org/pub/irods/releases/4.1.8/ubuntu14/irods-runtime-4.1.8-ubuntu14-x86_64.deb -o irods-runtime.deb \
    && curl ftp://ftp.renci.org/pub/irods/releases/4.1.8/ubuntu14/irods-icommands-4.1.8-ubuntu14-x86_64.deb -o irods-icommands.deb \
    && sudo dpkg -i irods-runtime.deb irods-icommands.deb \
    && sudo apt-get -f install \
    && rm irods-runtime.deb irods-icommands.deb

ADD requirements.txt /opt
ADD package.json /opt
RUN pip install --upgrade pip
RUN pip install -r /opt/requirements.txt
RUN cd /opt && npm install
RUN npm install -g astrum

RUN USE_SETUPCFG=0 \
    HDF5_INCDIR=/usr/include/hdf5/serial \
    pip install netCDF4==1.2.4

# Install GDAL 2.1.0 from source
RUN wget http://download.osgeo.org/gdal/2.1.0/gdal-2.1.0.tar.gz \
    && tar -xzf gdal-2.1.0.tar.gz \
    && rm gdal-2.1.0.tar.gz

WORKDIR /usr/src/gdal-2.1.0
RUN ./configure --with-python --with-geos=yes \
    && make \
    && sudo make install \
    && sudo ldconfig

# Cleanup
WORKDIR /
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root
WORKDIR /hydroshare

CMD ["/bin/bash"]

