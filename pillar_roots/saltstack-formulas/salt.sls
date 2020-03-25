salt:
  install_packages: False
  master:
    file_roots:
      base:
            {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
        - /usr/local/etc/salt/states
            {%- elif grains['kernel'] in ['Darwin',] %}
        - /usr/local/etc/salt
            {%- else %}
        - /srv/salt
            {%- endif %}
    pillar_roots:
      base:
        - /srv/pillar
  minion:
    file_roots:
      base:
            {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
        - /usr/local/etc/salt/states
            {%- elif grains['kernel'] in ['Darwin',] %}
        - /usr/local/etc/salt
            {%- else %}
        - /srv/salt
            {%- endif %}
    pillar_roots:
      base:
        - /srv/pillar
  ssh_roster:
    controller1:
      host: {{ grains.ipv4[0] or grains.ipv6[1] }}
      user: stack
      sudo: True
      priv: /etc/salt/ssh_keys/sshkey.pem
salt_formulas:
  git_opts:
    default:
      baseurl: https://github.com/saltstack-formulas
         {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
      basedir: /usr/local/etc/salt/states/namespaces/saltstack-formulas
            {%- elif grains['kernel'] in ['Darwin',] %}
      basedir: /usr/local/etc/salt/namespaces/saltstack-formulas
         {%- else %}
      basedir: /srv/salt/namespaces/saltstack-formulas
         {%- endif %}
  basedir_opts:
    makedirs: True
    user: root
      {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
    group: wheel
      {%- else %}
    group: root
      {%- endif %}
    mode: 755
  minion_conf:
    create_from_list: True
  list:
    base:
     {{ '- epel-formula' if grains.os_family in ('RedHat',) else '' }}
     - salt-formula
     - openssh-formula
     - packages-formula
     - firewalld-formula
     - eclipse-formula
     - tomcat-formula
     - sqlplus-formula
     - sqldeveloper-formula
     - sun-java-formula
     - users-formula
     - kubernetes-formula
     - cloudfoundry-formula
     - postgres-formula
     - jetbrains-intellij-formula
     - jetbrains-pycharm-formula
     - etcd-formula
     - ceph-formula
     - deepsea-formula
     - docker-formula
     - etcd-formula
     - firewalld-formula
     - helm-formula
     - iscsi-formula
     - lvm-formula
     - packages-formula
     - devstack-formula
     - golang-formula
     - memcached-formula
     - opensds-formula
     - mysql-formula
     - timezone-formula
     - resolver-formula
     - nginx-formula
     - mongodb-formula
     - apache-formula
     - prometheus-formula
     - grafana-formula
     - sysstat-formula
