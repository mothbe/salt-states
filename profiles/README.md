# profiles

Contains basic states

## update_system

### Basic usage
```
salt minion state.apply profiles.update_system
`

```
salt minion state.apply profiles.update_system pillar='{"update_system": {"cache_valid_time": 3600}}'
```

## password_reset

### Password (hash) changes every time on minion if hass_password is set to True
```
salt minion state.sls profiles.password_reset pillar='{ "password_reset": { "root": { "password": "s3cr3t", "hash_password": True } } }'
```

### Before must to generate hash
```
salt minion state.sls profiles.password_reset pillar='{"password_reset": {"root": {"password": "$6$OuQpIuHL627IOZSR$ZUkPue75YQ59LkLjeFdC6WdROgGv/WV.53OkaOYRVu4U9DVxQS0HG0PTZHG8IKg4WOwxo2y0gQYcApoDQElAD0"}}}'
```

### Generate password

SHA512
```
python3 -c 'import crypt; print(crypt.crypt("s3cr3t", crypt.mksalt(crypt.METHOD_SHA512)))'
```

MD5
```
openssl passwd -1
```

### Manage SSH public keys for user (pillar.example4)

```
salt minion state.sls profiles.password_reset pillar='{"password_reset": {"root": {"ssh_auth_absent": ["AAAAB3NzaC1yc2EAAAADAQABAAABAQDU3yivVxJ78aPL4LkxQk5AP+m05yH36bu58oiGr4f0iJARFRov74VrgogYP1dPsMy8u2dYEUURQ+64EJ304wwzK0scXyerdLrrKnAh0Az5uQsnC8r7mmonj2qjuA6YQo3mCem4ckfeJ40x97RClXVI5/WF+wGaPKzxJXAxmDXyuiHpbBv3oV8H/BMGF675ONn4CNFojgdGsjgSpIYzZFh97njSUUOKW9hsbxtPCqFjVVJL7MdkGjTm5S/2ybFGcQI9snRXzCQXuZcsjvqolxX5a3kN5xSGIMM9zRTZ/nZ/UpQ2fbW9Ff/XksOGmoRupKH1+YtqXOS0xNtXcWscPCOv"], "ssh_auth_present": ["AAAAB3NzaC1yc2EAAAADAQABAAABAQC6Gt4NZIvSBQvpyk5e5t6w5Z0Vkbc/x1+oQOxzWiMc9pHKvMaadLPtIy8hTbn8pmoAKE2pwbo61r/7/yRFtuKa/+DWbhHg59i/LjSLx+LzxSY7fMU+Y8c3/GAhZH07T12JsL9ZKnK79kHaGg7ibCglvpKKvTvkBFVabs5SJZx4OZyfRgOgIW0qy5SADFdckbI/qdtHVaH5rncSaEI7WPJa1hs8yr2oxSGuYJAPC2831wzyhZJg3XfolQzPHtMKlhKgGz4HDXjjfwCfqPuR43s2M+wPwdcaZqtEDtiwUD7x/4YOiGSncfLce53o2wjKzHBaUw6WS7pBPsioAgj6lWqf"]}}}'
```
