base:
  'master':
    - packages.master
  'client1':
    - packages.common
    - packages.minion
    - openssh.config
    - elements.motd

