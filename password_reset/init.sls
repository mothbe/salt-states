# -*- coding: utf-8 -*-
# vim: ft=sls

{% for name, user in pillar.get('password_reset', {}).items() %}
{{ name }}_password:
  user.present:
    - name: {{ name }}
    - password: {{ user.get('password') }}
    - hash_password: {{ user.get('hash_password', False) }}

{% if 'ssh_auth_present' in user %}
{% for auth in user.get('ssh_auth_present') -%}
user_ssh_auth_present_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - name: {{ auth }}
    - user: {{ name }}
    - enc: {{ user.get('enc', 'ssh-rsa') }}
    - comment: {{ user.get('comment', name) }}
{% endfor %}
{% endif %}

{% if 'ssh_auth_absent' in user %}
{% for auth in user.get('ssh_auth_absent') -%}
user_ssh_auth_absent_{{ name }}_{{ loop.index0 }}:
  ssh_auth.absent:
    - name: {{ auth }}
    - user: {{ name }}
    - enc: {{ user.get('enc', 'ssh-rsa') }}
    - comment: {{ user.get('comment', name) }}
{% endfor %}
{% endif %}

{% endfor %}
