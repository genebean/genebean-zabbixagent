#!/bin/bash
rsync -Pazv -r --exclude=".*/" --delete-after /home/mbojko/Documents/foreman/zabbixagent/ root@foreman.home.lan:/etc/puppetlabs/code/environments/development/modules/zabbixagent


