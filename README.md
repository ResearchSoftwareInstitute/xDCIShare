### Nightly Build Status (develop branch)

| Workflow | Clean | Build/Deploy | Unit Tests | Flake8
| :----- | :--- | :--- | :-------- | :------------ | :----------- |
| [![Build Status](http://ci.myhpom.renci.org:8080/job/nightly-build-workflow/badge/icon?style=plastic)](http://ci.myhpom.renci.org:8080/job/nightly-build-workflow/) | [![Build Status](http://ci.myhpom.renci.org:8080/job/nightly-build-clean/badge/icon?style=plastic)](http://ci.myhpom.renci.org:8080/job/nightly-build-clean/) | [![Build Status](http://ci.myhpom.renci.org:8080/job/nightly-build-deploy/badge/icon?style=plastic)](http://ci.myhpom.renci.org:8080/job/nightly-build-deploy/) | [![Build Status](http://ci.myhpom.renci.org:8080/job/nightly-build-test/badge/icon?style=plastic)](http://ci.myhpom.renci.org:8080/job/nightly-build-test/) | [![Build Status](http://ci.myhpom.renci.org:8080/job/nightly-build-flake8/badge/icon?style=plastic)](http://ci.myhpom.renci.org:8080/job/nightly-build-flake8/) |

Build generate by [Jenkins CI](http://ci.myhpom.renci.org:8080)

### requires.io
[![Requirements Status](https://requires.io/github/SoftwareResearchInstitute/MyHPOM/hs_docker_base/requirements.svg?branch=develop)](https://requires.io/github/SoftwareResearchInstitute/MyHPOM/hs_docker_base/requirements/?branch=master)

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

If you have docker installed locally, you can use `hsctl` commands to setup a
local development environment without VirtualBox.

*OS X Users* note that `hsctl` requires gnu sed. You can use
[homebrew](https://brew.sh) to install it as the default using the following
command: `brew install gnu-sed --with-default-names`.

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

Deployment
----------

Deployments settings can also take advantage of dotenv based settings by
specifying any variables directly in a .env file. The staging deployment
configuration is configured this way and requires the following steps to do a
formal deploy:

Any custom configuration is stored within `.env.staging.template.gpg`, a
[gpg](https://www.gnupg.org/) encrypted file. Ask another developer or
sysadmin for the password to edit this file. To make changes to the
configuration decrypt the file, make changes, and encrypt it again:

```shell
# decrypt the settings that are under version control:
echo PASSWORD | gpg --batch --yes --passphrase-fd 0 --decrypt .env.staging.template.gpg

# edit the decrypted file .env.staging.template

# encrypt the modified file, and commit:
echo PASSWORD | gpg --batch --yes --passphrase-fd 0 --symmetric .env.staging.template
```

When Jenkins checks out a version of this project it will decrypt this file ,
run it through the `envsubst` to fill in any variables provided by Jenkins, and
save the results in `.env`. Jenkins uses the following simple script to deploy:

```shell
rm -f .env .env.template

# Decrypt the environmental variables for staging:
echo PASSWORD | gpg --batch --yes --passphrase-fd 0 --decrypt .env.staging.template.gpg

# substitutes Jenkins environmental variables into the .env file
cat .env.staging.template | envsubst > .env
./hsctl rebuild --db
```

Provisioning New Servers
------------------------

When a new server is created, MyHPOM requires a few additional packages. The
following steps have been used to set up docker (for hsctl) and java (for
jenkins) and add the deploy user to docker group.

```shell
sudo yum install java-1.8.0-openjdk docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker xdci-service
sudo systemctl restart docker
# at this point I had to disconnect the one node I had set up for mhpom-dev b/c it was keeping itself online
# and therefor not getting a refresh of its groups and couldn't connect to docker.

# create the xdci-service user's home directory by logging in for the first time:
sudu su - xdci-service

# also I copied /root/ssl from myhpom into /home/xdci-service/ssl for use of the dev deploy.
```
