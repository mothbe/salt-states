# salt-states

### Password (hash) changes every time on minion!!!
```
salt minion1 state.sls users.root_password_set pillar='{ "users": { "root": { "password": "SuperSecret", "hash_password": True } } }'
```

Before execute create hash ( openssl passswd -1)
```
salt minion1 state.sls users.root_password_set pillar='{ "users": { "root": { "password": "$1$slHWdiZJ$43skMAR53PB/iFDy5SeeC.", "hash_password": False } } }'
```

### Upgrade packages on machine:
```
salt minion1 state.apply packages.update pillar='{ "packages": { "update": { "cache_valid_time": 3600 } } }'
```
