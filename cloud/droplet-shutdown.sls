shutdown-droplet:
  droplet.shutdown:
    - name: {{ pillar['instance_name'] }}
    - token: {{ pillar['token'] }}
