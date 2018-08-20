#!/bin/bash

# errexit: abort script at first error
set -e

PARSED=$(getopt --options=h,d,a:,e,v --longoptions=help,db,auth:,environment:,verbose --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
  # e.g. $? == 1
  #  then getopt has complained about wrong arguments to stdout
  exit 2
fi

BASIC_AUTH=""
ENV="staging"
HSCTL_OPTS=""

eval set -- "$PARSED"
while true; do
  case "$1" in
    -h|--help)
      echo "$0: deploy MyHPOM"
      echo ""
      echo "Usage: deploy-myhpom [-h/help,-a/auth,-e/environment,-d/db,-v/verbose] VAULT_PASSWORD"
      echo ""
      echo "Options:"
      echo " -a|--auth        : configure HTTP Basic Auth with the supplied password."
      echo " -d|--db          : If supplied, run hsctl with --db option"
      echo " -e|--environment : Deploy staging/production environment (default: staging)."
      echo " -h|--help"
      echo " -v|--verbose"
      exit 0
      ;;
    -v|--verbose)
      # print command to stdout before executing it:
      set -x
      shift
      ;;
    -d|--db)
      HSCTL_OPTS="--db"
      shift
      ;;
    -e|--environment)
      ENV="$2"
      shift 2
      if [[ ! "${ENV}" =~ ^(staging|production)$ ]]
      then
	echo "--environment must be staging or production"
	exit 2
      fi
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
if [[ $# -ne 1 ]]; then
  echo "$0: This script takes ANSIBLE_PASSWORD"
  exit 4
fi

ANSIBLE_PASSWORD=$1

rm -f .env .env.template

# ANSIBLE_PASSWORD and assumed to be provided by Jenkins:
echo "${ANSIBLE_PASSWORD}" > deploy/.vault-key

cd deploy
ansible-vault decrypt --output=_env.$ENV.template files/environment/_env.$ENV.template
cat _env.$ENV.template | envsubst > ../.env
rm _env.$ENV.template
cd ..

if [[ -n "$BASIC_AUTH" ]]; then
  htpasswd -bc nginx/.htpasswd $BASIC_AUTH $BASIC_AUTH
fi

./hsctl maint_on
./scripts/backup-hs
./hsctl rebuild $HSCTL_OPTS
./hsctl maint_off
