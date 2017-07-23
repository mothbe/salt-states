base:
  'master':
    - packages.master
  'client1':
    - packages.common
    - packages.minion
    - openssh.config
    - elements.motd
    - users
  'minion*':
    - elements.motd
    - packages.common
    - users.root_password_set
