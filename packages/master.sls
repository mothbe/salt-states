hold_master_packages:
  pkg.installed:
    - pkgs:
      - salt-minion
      - salt-common
      - salt-master
    - hold: True
