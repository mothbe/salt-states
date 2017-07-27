base:
  'minion*':
    - profiles.update_system
    - profiles.password_reset
    - crons
