# -*- coding: utf-8 -*-
# vim: ft=sls

{% for name, cron in pillar.get('crons', {}).items() %}

{% for job_enable in cron.get('crons_enabled', []) %}
cron_present_{{ job_enable }}:
  cron.present:
    - name:       {{ job_enable }}
    - user:       {{ job_enable.get('user', 'root' ) }}
    - minute:     {{ job_enable.get('minute', '"*"' ) }}
    - hour:       {{ job_enable.get('hour', '"*"' ) }}
    - daymonth:   {{ job_enable.get('daymonth', '"*"' ) }}
    - month:      {{ job_enable.get('month', '"*"' ) }}
    - dayweek:    {{ job_enable.get('dayweek', '"*"' ) }}
    - comment:    {{ job_enable.get('comment', None) }}
{% endfor %}

{% endfor %}
