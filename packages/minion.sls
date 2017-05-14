hold_minion_packages:
  pkg.installed:
    - pkgs:
      - salt-minion
      - salt-common
    - hold: True
