# crons

Description
-----------
Formula for management of cron jobs


Usage
-----

The simplest use case:

```
salt minion state.sls crons pillar='{"crons": {"/usr/local/minutes": {"comment": "comment1", "minute": 2, "user": "root"}, "/usr/local/hours": {"comment": "Komentarz_q", "commented": false, "minute": 1, "user": "root"}, "/usr/local/weeks": {"absent": true, "user": "root"}}}'
```


Available states
------------------

* `cron_env`
* `cron_jobs`

#### `cron_env`

```
salt minion state.sls crons.cron_env pillar='{"cron_env_vars": {"MAILTO": {"user": "root", "value": "root@localhost"}, "PATH": {"user": "root", "value": "/bin:/usr/bin"}, "VAR": {"absent": true, "user": "root", "value": 3}}}'
```

#### `cron_jobs`

```
salt minion state.sls crons.cron_jobs pillar='{"crons": {"/usr/local/hourly": {"comment": "comment2", "commented": false, "minute": 1, "user": "root"}, "/usr/local/minutes": {"comment": "comment1", "minute": 2, "user": "root"}, "/usr/local/weekly": {"absent": true, "user": "root"}}}'
```

