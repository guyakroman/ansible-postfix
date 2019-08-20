#!/bin/bash


echo -e " \n====== Start Zookeeper ======"
pdsh -w jchadcen[27,28,29] /opt/cluster/zookeeper/bin/zkServer.sh start

echo -e " \n====== Start HDFS ======"
pdsh -w jchadcen[11] start-dfs.sh

echo -e " \n====== Start Job Yarn ======"
pdsh -w jchadcen[17,12] start-yarn.sh

echo -e " ======= Start Job HistoryServer ====== "
pdsh -w jchadcen[12] mr-jobhistory-daemon.sh start historyserver

echo -e " \n====== Start Hive/metastore/hiveserver2 ======"
pdsh -w jchadcen[19] "hive --service metastore >/var/log/hive/metastore.out 2>/var/log/hive/metastore.log &"
pdsh -w jchadcen[19] "hive --service hiveserver2 >/var/log/hive/hiveserver2.out 2>/var/log/hive/hiveserver2.log &"

# ---------------------- STATUS ---------------------------------------#
#echo -e " ======= Status Job HistoryServer ====== "
#pdsh -w jchadcen[12] mr-jobhistory-daemon.sh status historyserver

echo -e " \n====== Status Job Yarn ======"
pdsh -w jchadcen[17,12] jps

echo -e " \n====== Status HDFS ======"
pdsh -w jchadcen[11,18,24] jps

echo -e " \n====== Status Zookeeper ======"
pdsh -w jchadcen[27,28,29] /opt/cluster/zookeeper/bin/zkServer.sh status

echo -e " \n====== Status Hive ======"
pdsh -w jchadcen[19] jps | grep RunJar
