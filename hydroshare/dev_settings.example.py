from hydroshare.local_settings import *   # NOQA

# These secret keys are used by the pg.myhpomdevelopment.sql development dump,
# if you change these, you will not be able to login with users setup in the
# dump:
SECRET_KEY = '9e2e3c2d-8282-41b2-a027-de304c0bc3d944963c9a-4778-43e0-947c-38889e976dcab9f328cb-1576-4314-bfa6-70c42a6e773c'
NEVERCACHE_KEY = '7b205669-41dd-40db-9b96-c6f93b66123496a56be1-607f-4dbf-bf62-3315fb353ce6f12a7d28-06ad-4ef7-9266-b5ea66ed2519'

DEBUG = True

NEVERCACHE_KEY='dev_nevercache_key'
SECRET_KEY='dev_secret_key'
