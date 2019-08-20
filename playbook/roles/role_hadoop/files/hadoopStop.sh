#!/bin/bash

echo -e " **** Stop Job HistoryServer "
pdsh -w jchadcen[12] mr-jobhistory-daemon.sh stop historyserver


echo -e " \n**** Stop Job Yarn "
pdsh -w jchadcen[17,12] stop-yarn.sh

echo -e " \n**** Stop Hive "
pdsh -w jchadcen[19] "ps -ef | grep -v grep | grep hive | awk '{print $2}' | xargs kill"

echo -e " \n**** Stop HDFS "
pdsh -w jchadcen[11] stop-dfs.sh

echo -e " \n**** Stop Zookeeper "
pdsh -w jchadcen[27,28,29] /opt/cluster/zookeeper/bin/zkServer.sh stop

echo -e " \n**** Check status "
pdsh -w jchadcen[11-19,24] jps
