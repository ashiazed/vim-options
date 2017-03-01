"""Fabfile for automating some mundane tasks."""
from fabric.api import cd, env, prefix, run

# Use local SSH config
env.use_ssh_config = True


def prod():
    """Production host."""
    env.hosts = ['myserver']
    env.virtual_env = 'projname'
    env.forward_agent = True


def prod_old():
    """Old way of defining."""
    env.user = 'cody'
    env.hosts = ['123.123.123.123:1234']
    env.virtual_env = 'projname'
    env.forward_agent = True


def deploy_virstualenv():
    """Deploy through virtualenv."""
    with prefix('workon {}'.format(env.virtual_env)):
        run('deploy')


def deploy_git_folder():
    """Deploy the application."""
    with cd('www'):
        run('git fetch origin master')
        run('git reset --hard origin/master')
