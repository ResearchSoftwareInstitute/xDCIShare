Summary
=======

Deployment scripts for the MyHPOM project.

There are currently two configurations managed by these scripts:

 * Provisioning new servers.

Some certificates managed by ansible are encrypted using ansible vault. You must
obtain a password and store it in `deploy/.vault-key` in order for files to be
unencrypted. Contact another developer or check the Keybase channels.

This requires that you have ansible installed (v2.3+).

Provisioning
------------

When a new server is created the provisioning script below can be run manually
to login to the server and ensure that system packages have been set up, users
have SSH conigured, and that docker is properly configured.

    ansible-playbook -i staging --extra-vars "ansible_become_pass=YOURPASSWORD" provision.yml

Note that sudo requires you by default to enter your password on the renci.org
password - so you must pass your password while provisioning the servers.

Deployment
----------

Deployment settings can also take advantage of dotenv based settings by
specifying any variables directly in a .env file. The staging deployment
configuration is configured this way and requires the following steps to do a
formal deploy:

Any custom configuration is stored within
`deploy/files/environment/_env.staging.template` (or the production equivalent), which is an
[Ansible Vault](https://docs.ansible.com/ansible/2.4/vault.html) encrypted file. Ask another developer or
sysadmin for the `.vault-key` password file, which should be stored in the deploy directory.

```shell
cd deploy

# to edit staging variables
ansible-vault edit files/environment/_env.staging.template

# commit changes to git.
```

When Jenkins checks out a version of this project it will decrypt this file,
run it through the `envsubst` to fill in any variables provided by Jenkins, and
save the results in `.env`. Jenkins uses the following simple script to deploy:

```shell
# see options available:
./scripts/deploy-myhpom.sh --help

# deploy to staging:
./scripts/deploy-myhpom.sh ANSIBLE_VAULT_PASSWORD
```
