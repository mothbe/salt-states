# crons

### Managment of cron jobs
```
salt minion state.sls crons pillar='{"crons": {"/usr/local/minutes": {"comment": "comment1", "minute": 2, "user": "root"}, "/usr/local/hours": {"comment": "Komentarz_q", "commented": false, "minute": 1, "user": "root"}, "/usr/local/weeks": {"absent": true, "user": "root"}}}'
```

### Management of cron environment variables
```
salt minion state.sls crons pillar='{"cron_env_vars": {"MAILTO": {"user": "root", "value": "root@localhost"}, "PATH": {"user": "root", "value": "/bin:/usr/bin"}, "VAR": {"absent": true, "user": "root", "value": 3}}}'
```

