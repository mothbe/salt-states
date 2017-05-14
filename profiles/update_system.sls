# -*- coding: utf-8 -*-
# vim: ft=sls

update_system:
  pkg.uptodate:
    - refresh: True
    - cache_valid_time: {{ salt['pillar.get']('update_system:cache_valid_time') }}
