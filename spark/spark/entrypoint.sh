#!/bin/bash

cat << EOF > ~/.ssh/config
Host *
    StrictHostKeyChecking no
EOF

/etc/init.d/ssh restart

if [[ $# -gt 0 ]] ; then
    eval "$1"
fi