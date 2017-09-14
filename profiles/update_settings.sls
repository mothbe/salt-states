# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if salt['pillar.get']('update_settings:disabled') %}
set_disable:
  grains.present:
    - name: disabled
    - value: {{ salt['pillar.get']('update_settings:disabled') }}
    - force: True
{%- endif %}

{%- if salt['pillar.get']('update_settings:hostname') %}
set_hostname:
  cmd.run:
    {% if grains["init"] == "systemd" %}
    - name: hostnamectl set-hostname {{ salt['pillar.get']('update_settings:hostname') }}
    {% endif %}
    - unless: test "{{ salt['pillar.get']('update_settings:hostname') }}" = "$(hostname)"
{%- endif %}
