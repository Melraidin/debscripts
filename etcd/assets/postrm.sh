#!/bin/bash

# If etcd user, delete
cat /etc/passwd | cut -d : -f 1 | grep etcd
if [[ $? -eq 0 ]]; then
  userdel etcd || exit $?
fi

# Delete upstart script
if [[ -e /etc/init/etcd.conf  ]]; then
  rm /etc/init/etcd.conf || exit $?
fi

if [[ -e /etc/init.d/etcd  ]]; then
  rm /etc/init.d/etcd || exit $?
fi

# If dpkg deletes /opt like a jerk
# http://stackoverflow.com/questions/13021002/my-deb-file-removes-opt
if [[ ! -d /opt ]]; then
  mkdir /opt
fi