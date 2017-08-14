stop-droplet:
  droplet.power_off:
    - name: {{ pillar['instance_name'] }}
    - token: {{ pillar['token'] }}
