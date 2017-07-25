{% for name, cron in pillar.get('crons_crons_enabled', {}).items() %}

cron_present_{{ name }}:
  cron.present:
    - name:       {{ name }}
    - user:       {{ cron.get('user', 'root' ) }}
    - minute:     {{ cron.get('minute', '*' ) }}
    - hour:       {{ cron.get('hour', '*' ) }}
    - daymonth:   {{ cron.get('daymonth', '*' ) }}
    - month:      {{ cron.get('month', '*' ) }}
    - dayweek:    {{ cron.get('dayweek', '*' ) }}
    - comment:    {{ cron.get('comment', None) }}
    - commented:  {{ cron.get('commented', None) }}
    - identifier: {{ cron.get('identifier', False) }}
    - special:    {{ cron.get('special', None) }}

{% endfor %}