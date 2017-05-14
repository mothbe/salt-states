hold_master_packages:
  pkg.installed:
    - pkgs:
      - salt-minion
      - salt-common
    - hold: True
