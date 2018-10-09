import os
from invoke import Collection, task, Exit


@task
def test(c):
    """ Run tests, linters, and coverage. """
    c.run('flake8')

    migrations = c.run(
        'python manage.py makemigrations --dry-run | grep -v "No changes"',
        env=os.environ, warn=True)
    if len(migrations.stdout) > 0:
        print(migrations.stdout)
        raise Exit('makemigrations is showing that migration is missing!')

    c.run('python manage.py test --keepdb', env=os.environ)


# when running fab commands, echo the command before running:
ns = Collection(test)
ns.configure({'run': {'echo': True}})
