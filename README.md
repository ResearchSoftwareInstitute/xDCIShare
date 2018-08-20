MyHPOM
============

MyHPOM is a collaborative website being developed for better management of personal health and healthcare information. MyHPOM is derived directly from the NSF-funded 3-clause BSD [HydroShare open source codebase](https://github.com/hydroshare/hydroshare), NSF awards [1148453](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1148453) and [1148090](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1148090). MyHPOM provides the sustainable technology infrastructure needed to address planning and communicating important information about your future healthcare wishes to those closest to you and those who provide medical care to you.

If you want to contribute to MyHPOM, please see the [MyHPOM Wiki](https://github.com/SoftwareResearchInstitute/MyHPOM/wiki/).

More information can be found in the [MyHPOM Wiki](https://github.com/SoftwareResearchInstitute/MyHPOM/wiki/).

Development
===========

There are very good instructions on the [hydroshare
wiki](https://github.com/hydroshare/hydroshare/wiki/getting_started) to set up a
local dev environment that matches production.

Docker Development
==================

If you have [docker installed](https://www.docker.com/community-edition#/download) locally, you can use `hsctl` commands to setup a
local development environment without VirtualBox.

```bash
# Copy the developer settings template, and configure your system to use it:
echo "LOCAL_SETTINGS=dev_settings" > .env
cp hydroshare/dev_settings.example.py hydroshare/dev_settings.py

# Rebuild your local developer environment, and install a database snapshot:
./hsctl rebuild --db

# To see which services are running, one would expect to see the following
# services:
docker-compose ps

Name            Command                          State   Ports
-------------------------------------------------------------------------------------------------------
defaultworker   /bin/bash init-defaultworker     Up
hydroshare      /bin/bash init-hydroshare        Up      0.0.0.0:1338->2022/tcp, 0.0.0.0:8000->8000/tcp
postgis         /docker-entrypoint.sh postgres   Up      5432/tcp
rabbitmq        /docker-entrypoint.sh rabb ...   Up      25672/tcp, 4369/tcp, 5671/tcp, 5672/tcp
redis           docker-entrypoint.sh redis ...   Up      6379/tcp
solr            sh -c /bin/bash /opt/solr/ ...   Up      8983/tcp

# To look at logs for any service, you can use docker-compose. For instance to
# see the django server logs:
docker-compose logs -f hydroshare

# When you are done developing, and want to stop the services (analagous to docker-compose stop)
./hsctl stop

# To restart your stack again (without replacing the database):
./hsctl rebuild

# To run a manage.py command:
./hsctl managepy createsuperuser

# If you want to set breakpoints, you can stop the existing hydroshare you
# can manually execute runserver yourself:
docker-compose stop hydroshare
# create a new hydroshare server, with service ports exposed, and run
# whatever django command you wish to run:
docker-compose run --rm --service-ports hydroshare bash
python manage.py runserver 0.0.0.0:8000
# exit the docker instance when done:
exit

# To run tests (which take about an hour to run):
./hsctl managepy test
```

*OS X Users* note that scripts require some gnu versions of builtin libraries.
You can use [homebrew](https://brew.sh) to install it as the default using the
following commands:
 * `brew install gnu-sed --with-default-names`.
 * `brew install gnu-getopt ; brew link --force gnu-getopt`.
 * `brew install gettext ; brew link --force gettext`.

Environments
------------

This project extends the hydroshare configuration by allowing one to override
settings from a .env file. Most common configurable settings will be picked up
from this file.

In local development one can override local settings by copying a local .env
template and customizing it:

```shell

cp ./.env.example .env
cp ./hydroshare/dev_settings.example.py ./hydroshare/dev_settings.py
```

Once these changes are made you can customize your development environment
within your dev_settings.py (which will not be added to git).

You can also use the .env file to specify a different hydroshare-config.yaml
derived file (i.e., a production version).

Deployment and Provisioning
---------------------------

When a new server is created, MyHPOM requires a few additional packages. The
following steps have been used to set up docker (for hsctl) and java (for
jenkins) and add the deploy user to docker group. See the [deployment
docs](deploy/README.md) for more information.

Code Style Notes
================


BEM
---

To ensure that the MyHPOM app uses a set of selectors that can be layered
on top of Bootstrap without conflicts as well as to ensure that style
rules are legible and follow a maintainable convention, MyHPOM's app-specific
selectors are written in the [BEM (Block Element Modifier)](getbem.com) style.

When creating new front-end components, please follow the convention of
creating a new "block" class for your component (e.g. `.pseudo-modal`),
specifying rules for component-internal elements in un-nested selectors
following the "element" pattern (e.g. `.pseudo-modal__headline`),
and specifying rules for variations on either by means of the "modifier"
convention (e.g. `.pseudo-modal__headline--subtitle`).
