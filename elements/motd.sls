# -*- coding: utf-8 -*-
# vim: ft=sls

/etc/motd:
  file.managed:
    - template: jinja
    - source: salt://elements/files/motd
