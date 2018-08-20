FROM mjstealey/hs_docker_base:1.9.5
MAINTAINER Michael J. Stealey <stealey@renci.org>

### Begin - HydroShare Development Image Additions ###
ADD requirements.txt /opt
ADD package.json /opt
RUN pip install --upgrade pip
RUN pip install -r /opt/requirements.txt
RUN cd /opt && npm install
RUN npm install -g astrum
### End - HydroShare Development Image Additions ###

# Install Ghostscript
ADD install-gs.sh /opt
RUN /opt/install-gs.sh

# Patch for Mezzanone 4.10 collecttemplates bugfix
RUN echo -e "\
\n42c42,44\
\n<         to_dir = settings.TEMPLATE_DIRS[0]\
\n---\
\n>         # Mezzanine 4.10 fix for collecttemplates.py\
\n>         # to_dir = settings.TEMPLATE_DIRS[0]\
\n>         to_dir = settings.TEMPLATES[0][\"DIRS\"][0]\
" | patch /usr/local/lib/python2.7/site-packages/mezzanine/core/management/commands/collecttemplates.py -

### End - MyHPOM Development Image Additions ###

USER root
WORKDIR /hydroshare

CMD ["/bin/bash"]
