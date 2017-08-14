start-droplet:
  droplet.power_on:
    - name: {{ pillar['instance_name'] }}
    - token: {{ pillar['token'] }}
