# -*- coding: utf-8 -*-
# vim: ft=sls

{% for name, cron in pillar.get('crons_disabled', {}).items() %}

cron_absent_{{ name }}:
  cron.absent:
    - name:       {{ name }}
    - user:       {{ cron.get('user', 'root' ) }}

{% endfor %}
