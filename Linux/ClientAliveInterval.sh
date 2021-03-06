#!/bin/bash
egrep -q "^\s*.*ClientAliveInterval\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 60/" /etc/ssh/sshd_config || echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
egrep -q "^\s*.*ClientAliveCountMax\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveCountMax\s\w+.*$/ClientAliveCountMax 30/" /etc/ssh/sshd_config || echo "ClientAliveCountMax 30" >> /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart