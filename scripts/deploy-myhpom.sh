#!/bin/bash

# nounset: undefined variable outputs error message, and forces an exit
set -u
# errexit: abort script at first error
set -e
# print command to stdout before executing it:
set -x

rm -f .env .env.template

# ANSIBLE_PASSWORD and NODE_NAME are assumed to be provided by Jenkins:
echo "${ANSIBLE_PASSWORD}" > deploy/.vault-key

ENV=staging
if [ "${NODE_NAME}" = 'myhpom' ]; then
  ENV=production
fi

echo "environment = $ENV"

cd deploy
ansible-vault decrypt files/environment/_env.$ENV.template
cat files/environment/_env.$ENV.template | envsubst > ../.env
cd ..

./hsctl maint_on
./scripts/backup-hs
./hsctl rebuild
./hsctl maint_off
