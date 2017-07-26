# -*- coding: utf-8 -*-
# vim: ft=sls

{% for name, env in pillar.get('cron_env_vars', {}).items() if env.absent is not defined or not env.absent %}
env_present_{{ name }}:
  cron.env_present:
    - name:       {{ name }}
    - user:       {{ env.get('user', 'root' ) }}
    - value:      {{ env.get('value', None ) }}
{% endfor %}


{% for name, env in pillar.get('cron_env_vars', {}).items() if env.absent is defined and env.absent %}
env_absent_{{ name }}:
  cron.env_absent:
    - name: {{ name }}
    - user: {{ env.get('user', 'root' ) }}
{% endfor %}
