{% for cron, args in pillar['crons'].iteritems() %}
set_cronjob_{{ cron }}_{{ args['name'] }}:
  cron.present:
    - name: {{ args['name'] }}
    - user: {{ args['user'] }}
    #- minute: 
    #- hour: '*'
    #- daymonth: '*'
    #- month: '*'
    #- dayweek: 2
    #- comment: test

{% endfor %}
