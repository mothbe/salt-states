install_common_packages:
  pkg.installed:
    - pkgs: {{ salt['pillar.get']('packages:pkgs') }}
