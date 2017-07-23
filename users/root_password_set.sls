---
root_password_set:
  user.present:
    - name: root
    - password: {{ salt['pillar.get']('users:root:password') }}
    - hash_password: {{ salt['pillar.get']('users:root:hash_password') }}


