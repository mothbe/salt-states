# -*- coding: utf-8 -*-
'''
Manage Droplet on DigitalOcean

This module provides an interface to start and stop Droplets
on DigitalOcean. State module makes use of the ``python-digitalocean`` module.

.. code-block:: yaml

    start_vm:
       droplet.power_on:
        - name: droplet_name
        - token: SecretToken

'''

import logging


try:
    import digitalocean
    HAS_DIGITALOCEAN = True
except ImportError:
    HAS_DIGITALOCEAN = False


def __virtual__():
    '''
    Only load droplet if python-digitalocean is available
    '''
    if HAS_DIGITALOCEAN:
        return 'droplet'
    else:
        return False('The droplet state module cannot be loaded: \
                     python-digitalocean unavailable.')


log = logging.getLogger(__name__)


class DOException(Exception):
    '''
    DigitalOcean exception related to name of VMs
    '''
    def __init__(self, msg):
        super(DOException, self).__init__("DigitalOcean error: {}".format(msg))


def _get_droplet(droplet_name, token):
    '''
    Make sure that VM `droplet_name` exists on DigitalOcean
    and VM name does not repeat itself.
    '''
    manager = digitalocean.Manager(token=token)
    droplets = manager.get_all_droplets()

    if sum(d.name == droplet_name for d in droplets) > 1:
        raise DOException("more than one VM with the same name")

    for droplet in droplets:
        if droplet.name == droplet_name:
            return droplet.id
    raise DOException('missing droplet')


def power_on(name, token):
    '''
    Make sure that VM is running on DigitalOcean.

    name
        instance_name
    token
        secret from DigitalOcean

    '''
    ret = {
        'name': name,
        'changes': {},
        'result': True,
        'comment': '',
    }

    # Find exact droplet
    try:
        droplet_id = _get_droplet(name, token)
    except DOException as e:
        ret['comment'] = 'Unable to find instance {0}, {1}'.format(name, e)
        return ret

    droplet = digitalocean.Droplet.get_object(api_token=token,
                                              droplet_id=droplet_id)

    result = droplet.power_on()

    log.debug('Status: {0}\nType: {1}\
              \nStarted at: {2}\
              \nCompleted at: {3}i\
              \nResource ID: {4}\
              '.format(result['action']['status'],
                       result['action']['type'],
                       result['action']['started_at'],
                       result['action']['completed_at'],
                       result['action']['resource_id']))

    if droplet.status == "off" and not result['action']['status'] == "errored":
        ret['changes'] = {'old': {}, 'new': {}}
        ret['changes']['old']['status'] = droplet.status
        ret['changes']['new']['status'] = result['action']['status']
        ret['comment'] = 'Power on droplet: name {}, id {}'.format(name,
                                                                   droplet_id)

    elif droplet.status == 'active':
        ret['comment'] = 'Droplet is already running: ' \
            'name {}, id {}'.format(name, droplet_id)
    else:
        ret['result'] = False
        ret['comment'] = 'Unable to power on droplet: ' \
            'name {}, id {}'.format(name, droplet_id)

    return ret


def power_off(name, token):
    '''
    Make sure that VM is disabled on DigitalOcean.

    name
        instance_name
    token
        secret password from DigitalOcean

    '''
    ret = {
        'name': name,
        'changes': {},
        'result': True,
        'comment': '',
    }

    # Find exact droplet
    try:
        droplet_id = _get_droplet(name, token)
    except DOException as e:
        ret['comment'] = 'Unable to find instance {0}, {1}'.format(name, e)
        return ret

    droplet = digitalocean.Droplet.get_object(api_token=token,
                                              droplet_id=droplet_id)

    result = droplet.power_off()

    log.debug('Status: {0}\
              \nType: {1}\
              \nStarted at: {2}\
              \nCompleted at: {3}\
              \nResource ID: {4}'.format(result['action']['status'],
                                         result['action']['type'],
                                         result['action']['started_at'],
                                         result['action']['completed_at'],
                                         result['action']['resource_id']))

    if droplet.status == "active" and not \
            result['action']['status'] == "errored":
        ret['changes'] = {'old': {}, 'new': {}}
        ret['changes']['old']['status'] = droplet.status
        ret['changes']['new']['status'] = result['action']['status']
        ret['comment'] = 'Power off droplet: name {}, id {}'.format(name,
                                                                    droplet_id)
    elif droplet.status == 'off':
        ret['comment'] = 'Droplet has been disabled before: ' \
            'name {}, id {}'.format(name, droplet_id)
    else:
        ret['result'] = False
        ret['comment'] = 'Unable to power off droplet: ' \
            'name {}, id {}'.format(name, droplet_id)

    return ret


def shutdown(name, token):
    '''
    Shutdown VM on DigitalOcean.
    This state makes use of the ``python-digitalocean`` module to
    interact with AWS.

    name
        instance_name
    token
        secret password from DigitalOcean

    '''
    ret = {
        'name': name,
        'changes': {},
        'result': True,
        'comment': '',
    }

    # Find exact droplet
    try:
        droplet_id = _get_droplet(name, token)
    except DOException as e:
        ret['comment'] = 'Unable to find instance {0}, {1}'.format(name, e)
        return ret

    droplet = digitalocean.Droplet.get_object(api_token=token,
                                              droplet_id=droplet_id)

    result = droplet.shutdown()

    log.debug('Status: {0}\nType: {1}\
              \nStarted at: {2}\nCompleted at: {3}\
              \nResource ID: {4}'.format(result['action']['status'],
                                         result['action']['type'],
                                         result['action']['started_at'],
                                         result['action']['completed_at'],
                                         result['action']['resource_id']))

    if droplet.status == "active" and not \
            result['action']['status'] == "errored":
        ret['changes'] = {'old': {}, 'new': {}}
        ret['changes']['old']['status'] = droplet.status
        ret['changes']['new']['status'] = result['action']['status']
        ret['comment'] = 'Shutdown droplet: name {}, id {}'.format(name,
                                                                   droplet_id)
    elif droplet.status == 'off':
        ret['comment'] = 'Droplet has been disabled before: ' \
            'name {}, id {}'.format(name, droplet_id)
    else:
        ret['result'] = False
        ret['comment'] = 'Unable to shutdown droplet: ' \
            'name {}, id {}'.format(name, droplet_id)

    return ret
