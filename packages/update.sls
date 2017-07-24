update:
  pkg.uptodate:
    - cache_valid_time: {{ salt['pillar.get']('packages:update:cache_valid_time') }}
