#!/bin/bash

# errexit: abort script at first error
set -e

PARSED=$(getopt --options=h,a: --longoptions=help,auth: --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
  # e.g. $? == 1
  #  then getopt has complained about wrong arguments to stdout
  exit 2
fi

BASIC_AUTH=""

eval set -- "$PARSED"
while true; do
  case "$1" in
    -h|--help)
      echo "$0: deploy MyHPOM"
      echo ""
      echo "Usage: deploy-myhpom [-h,--help,-a,--auth] HOST VAULT_PASSWORD"
      echo ""
      echo "Options: When -a/--auth is provided, configure HTTP Basic Auth."
      exit 0
      ;;
    -a|--auth)
      BASIC_AUTH="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
  esac
done

# handle non-option arguments
if [[ $# -ne 2 ]]; then
  echo "$0: This script takes HOST and ANSIBLE_PASSWORD"
  exit 4
fi

NODE_NAME=$1
ANSIBLE_PASSWORD=$2

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

if [[ "$BASIC_AUTH" -ne "" ]]; then
  htpasswd -bc nginx/.htpasswd $BASIC_AUTH $BASIC_AUTH
fi

./hsctl maint_on
./scripts/backup-hs
./hsctl rebuild
./hsctl maint_off
