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

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid crash
ENV DISPLAY=:99

# install selenium
RUN pip install selenium==3.8.0

### End - MyHPOM Development Image Additions ###

USER root
WORKDIR /hydroshare

CMD ["/bin/bash"]
