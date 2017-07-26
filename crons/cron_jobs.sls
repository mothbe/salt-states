# -*- coding: utf-8 -*-
# vim: ft=sls

{% for name, cron in pillar.get('crons', {}).items() if cron.absent is not defined or not cron.absent %}
cron_present_{{ name }}:
  cron.present:
    - name:       {{ name }}
    - user:       {{ cron.get('user', 'root' ) }}
    - minute:     {{ cron.get('minute', '"*"' ) }}
    - hour:       {{ cron.get('hour', '"*"' ) }}
    - daymonth:   {{ cron.get('daymonth', '"*"' ) }}
    - month:      {{ cron.get('month', '"*"' ) }}
    - dayweek:    {{ cron.get('dayweek', '"*"' ) }}
    - comment:    {{ cron.get('comment', None) }}
    - commented:  {{ cron.get('commented', False) }}
    - identifier: {{ cron.get('identifier', False) }}
{% endfor %}


{% for name, cron in pillar.get('crons', {}).items() if cron.absent is defined and cron.absent %}
cron_absent_{{ name }}:
  cron.absent:
    - name: {{ name }}
    - user: {{ cron.get('user', 'root' ) }}
{% endfor %}
