{% for user, args in pillar['users'].iteritems() %}
{{ user }}_password_set:
  user.present:
    - name: {{ user }}
    - password: {{ args['password'] }}
    - hash_password: {{ args['hash_password'] }}

{{ user }}_ssh_auth_set:
  ssh_auth.present:
    - name: {{ args['ssh_auth'] }}
    - user: {{ user }}
    - enc: {{ args['enc'] }}
{% endfor %}
