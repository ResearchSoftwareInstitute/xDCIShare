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
