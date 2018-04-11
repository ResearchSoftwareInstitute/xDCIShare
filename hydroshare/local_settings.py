# DEVELOPMENT - local_settings.py
#    - This file should be copied to ~/hydroshare/hydroshare/local_settings.py
#    - The iRODS specific contents of this file contain username and password informaiton
#      that is used for an MyHPOM proxy user

import redis
import os
from kombu import Queue, Exchange
from kombu.common import Broadcast

DEBUG = os.environ.get('DEBUG') == 'true'

# These secret keys are used by the pg.myhpomdevelopment.sql development dump,
# if you change these, you will not be able to login with users setup in the
# dump:
# TODO These should not be a part of any production configuration, as anyone that
# gets a copy of the git repository will be able to access passwords on the
# sysstem. They should ultimately be a part of the dev settings template.
SECRET_KEY = os.environ.get('SECRET_KEY', '9e2e3c2d-8282-41b2-a027-de304c0bc3d944963c9a-4778-43e0-947c-38889e976dcab9f328cb-1576-4314-bfa6-70c42a6e773c')
NEVERCACHE_KEY = os.environ.get('NEVERCACHE_KEY', '7b205669-41dd-40db-9b96-c6f93b66123496a56be1-607f-4dbf-bf62-3315fb353ce6f12a7d28-06ad-4ef7-9266-b5ea66ed2519')

# TODO we should not allow any host by default, as it represents a security
# risk. See the Django docs: http://devdocs.io/django~1.8/ref/settings#std:setting-ALLOWED_HOSTS
ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '*')

RABBITMQ_HOST = os.environ.get('RABBITMQ_PORT_5672_TCP_ADDR', 'localhost')
RABBITMQ_PORT = '5672'

REDIS_HOST = os.environ.get('REDIS_PORT_6379_TCP_ADDR', 'localhost')
REDIS_PORT = 6379
POSTGIS_HOST = os.environ.get('POSTGIS_PORT_5432_TCP_ADDR', 'localhost')
POSTGIS_PORT = 5432
POSTGIS_DB = os.environ.get('POSTGIS_DB', 'postgres')
POSTGIS_PASSWORD = os.environ.get('POSTGIS_PASSWORD', 'postgres')
POSTGIS_USER = os.environ.get('POSTGIS_USER', 'postgres')

REDIS_CONNECTION = redis.Redis(
    host=REDIS_HOST,
    port=REDIS_PORT,
    db=4)
WMS_CACHE_DB = redis.Redis(
    host=REDIS_HOST,
    port=REDIS_PORT,
    db=5)
PERMISSIONS_DB= redis.Redis(
    host=REDIS_HOST,
    port=REDIS_PORT,
    db=6)


IPYTHON_SETTINGS=[]
IPYTHON_BASE='/hydroshare/static/media/ipython-notebook'
IPYTHON_HOST='127.0.0.1'

# celery settings
# customizations: we need a special queue for broadcast signals to all
# docker daemons.  we also need a special queue for direct messages to all
# docker daemons.
BROKER_URL='amqp://guest:guest@{RABBITMQ_HOST}:{RABBITMQ_PORT}//'.format(RABBITMQ_HOST=RABBITMQ_HOST, RABBITMQ_PORT=RABBITMQ_PORT)
CELERY_ACCEPT_CONTENT = ['json']
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'
CELERY_DEFAULT_QUEUE = 'default'
DEFAULT_EXCHANGE=Exchange('default', type='topic')

CELERY_QUEUES = (
    Queue('default', DEFAULT_EXCHANGE, routing_key='task.default'),
)
CELERY_DEFAULT_EXCHANGE = 'tasks'
CELERY_DEFAULT_EXCHANGE_TYPE = 'topic'
CELERY_DEFAULT_ROUTING_KEY = 'task.default'
CELERY_ROUTES = ('hs_core.router.HSTaskRouter',)

DOCKER_URL = 'unix://docker.sock/'
DOCKER_API_VERSION = '1.12'


# CartoCSS
CARTO_HOME='/hs_tmp/node_modules/carto'


USE_SOUTH = False
SITE_TITLE = "MyHPOM"

SESSION_EXPIRE_AT_BROWSER_CLOSE = True


#############
# DATABASES #
#############

DATABASES = {
    "default": {
        # Add "postgresql_psycopg2", "mysql", "sqlite3" or "oracle".
        "ENGINE": "django.contrib.gis.db.backends.postgis",
        # DB name or path to database file if using sqlite3.
        "NAME": POSTGIS_DB,
        # Not used with sqlite3.
        "USER": POSTGIS_USER,
        # Not used with sqlite3.
        "PASSWORD": POSTGIS_PASSWORD,
        # Set to empty string for localhost. Not used with sqlite3.
        "HOST": POSTGIS_HOST,
        # Set to empty string for default. Not used with sqlite3.
        "PORT": POSTGIS_PORT,
    }
}
POSTGIS_VERSION=(2,1,1)

# Local resource iRODS configuration
USE_IRODS = os.environ.get('USE_IRODS', 'true') == 'true'
IRODS_ROOT = os.environ.get('IRODS_ROOT', '/tmp')
IRODS_ICOMMANDS_PATH = os.environ.get('IRODS_ICOMMANDS_PATH', '/usr/bin')
IRODS_HOST = os.environ.get('IRODS_HOST', 'hydrotest41.renci.org')
IRODS_PORT = os.environ.get('IRODS_PORT', '1247')
IRODS_DEFAULT_RESOURCE = os.environ.get('IRODS_DEFAULT_RESOURCE', 'hydrotest41Resc')
IRODS_HOME_COLLECTION = os.environ.get('IRODS_HOME_COLLECTION', '/hydrotest41Zone/home/hsproxy')
IRODS_CWD = os.environ.get('IRODS_CWD', '/hydrotest41Zone/home/hsproxy')
IRODS_ZONE = os.environ.get('IRODS_ZONE', 'hydrotest41Zone')
IRODS_USERNAME = os.environ.get('IRODS_USERNAME', 'hsproxy')
IRODS_AUTH = os.environ.get('IRODS_AUTH', 'proxywater1')
IRODS_GLOBAL_SESSION = os.environ.get('IRODS_GLOBAL_SESSION', 'true') == 'true'

# Remote user zone iRODS configuration
REMOTE_USE_IRODS = os.environ.get('REMOTE_USE_IRODS', 'false') == 'true'

# iRODS customized bagit rule path
IRODS_BAGIT_RULE = os.environ.get('IRODS_BAGIT_RULE', 'hydroshare/irods/ruleGenerateBagIt_HS.r')
IRODS_BAGIT_PATH = os.environ.get('IRODS_BAGIT_PATH', 'bags')
IRODS_BAGIT_POSTFIX = os.environ.get('IRODS_BAGIT_POSTFIX', 'zip')

HS_BAGIT_README_FILE_WITH_PATH = os.environ.get('HS_BAGIT_README_FILE_WITH_PATH', 'docs/bagit/readme.txt')

# crossref login credential for resource publication
USE_CROSSREF_TEST = os.environ.get('USE_CROSSREF_TEST', 'true') == 'true'
CROSSREF_LOGIN_ID = os.environ.get('CROSSREF_LOGIN_ID', '')
CROSSREF_LOGIN_PWD = os.environ.get('CROSSREF_LOGIN_PWD', '')

# Since Hyrax server on-demand update is only needed when private netCDF resources on www
# are made public, in local development environments or VM deployments other than the www
# production, this should not be run by setting RUN_HYRAX_UPDATE to False. RUN_HYRAX_UPDATE
# should only be set to true on www.hydroshare.org
RUN_HYRAX_UPDATE = os.environ.get('RUN_HYRAX_UPDATE', 'false') == 'true'
HYRAX_SSH_HOST = os.environ.get('HYRAX_SSH_HOST', '')
HYRAX_SSH_PROXY_USER = os.environ.get('HYRAX_SSH_PROXY_USER', '')
HYRAX_SSH_PROXY_USER_PWD = os.environ.get('HYRAX_SSH_PROXY_USER_PWD', '')
HYRAX_SCRIPT_RUN_COMMAND = os.environ.get('HYRAX_SCRIPT_RUN_COMMAND', '')

# hsuserproxy system user configuration used to create MyHPOM iRODS users on-demand
HS_USER_ZONE_HOST = os.environ.get('HS_USER_ZONE_HOST', '')
HS_USER_ZONE_PROXY_USER = os.environ.get('HS_USER_ZONE_PROXY_USER', '')
HS_USER_ZONE_PROXY_USER_PWD = os.environ.get('HS_USER_ZONE_PROXY_USER_PWD', '')
HS_USER_ZONE_PROXY_USER_CREATE_USER_CMD = os.environ.get('HS_USER_ZONE_PROXY_USER_CREATE_USER_CMD', '')
HS_USER_ZONE_PROXY_USER_DELETE_USER_CMD = os.environ.get('HS_USER_ZONE_PROXY_USER_DELETE_USER_CMD', '')
HS_USER_ZONE_PRODUCTION_PATH = os.environ.get('HS_USER_ZONE_PRODUCTION_PATH', '/hydroshareuserZone/home/localHydroProxy')

# the local MyHPOM proxy user (a counterpart of wwwHydroProxy) in a federated zone with HydroShare Zone
HS_LOCAL_PROXY_USER_IN_FED_ZONE = os.environ.get('HS_LOCAL_PROXY_USER_IN_FED_ZONE', 'localTestHydroProxy')

# Please keep the line below unchanged since it is used to check whether
# the current site is in production or not
HS_WWW_IRODS_PROXY_USER = os.environ.get('HS_WWW_IRODS_PROXY_USER', 'wwwHydroProxy')
# credentials for MyHPOM proxy user iRODS account which is set to have own access control
# to all collections in any federated zone with HydroShare zone, which is only useful when
# testing HydroShare federated zone in local test development environment since in www
# production environment, IRODS_USERNAME and other associated settings already represent wwwHydroProxy settings
HS_WWW_IRODS_PROXY_USER_PWD = os.environ.get('HS_WWW_IRODS_PROXY_USER_PWD', '')
HS_WWW_IRODS_HOST = os.environ.get('HS_WWW_IRODS_HOST', '')
HS_IRODS_LOCAL_ZONE_DEF_RES = os.environ.get('HS_IRODS_LOCAL_ZONE_DEF_RES', 'hydroshareLocalResc')
HS_WWW_IRODS_ZONE = os.environ.get('HS_WWW_IRODS_ZONE', '')
HS_USER_IRODS_ZONE = os.environ.get('HS_USER_IRODS_ZONE', 'hydroshareuserZone')

# Email configuration
EMAIL_BACKEND = os.environ.get('EMAIL_BACKEND', 'django.core.mail.backends.console.EmailBackend')
EMAIL_HOST_USER = os.environ.get('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = os.environ.get('EMAIL_HOST_PASSWORD')
EMAIL_HOST = os.environ.get('EMAIL_HOST')
EMAIL_PORT = int(os.environ.get('EMAIL_PORT', 0))
EMAIL_USE_TLS = os.environ.get('EMAIL_USE_TLS', 'true') == 'true'
DEFAULT_FROM_EMAIL = os.environ.get('DEFAULT_FROM_EMAIL')
DEFAULT_SUPPORT_EMAIL = os.environ.get('DEFAULT_SUPPORT_EMAIL')

HYDROSHARE_SHARED_TEMP = os.environ.get('HYDROSHARE_SHARED_TEMP', '/shared_tmp')

TIME_ZONE = "America/New_York"

RECAPTCHA_VERIFY_URL='https://www.google.com/recaptcha/api/siteverify'
RECAPTCHA_SITE_KEY=os.environ.get('RECAPTCHA_SITE_KEY')
RECAPTCHA_SECRET_KEY=os.environ.get('RECAPTCHA_SECRET_KEY')
