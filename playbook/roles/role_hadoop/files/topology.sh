set -x
RACK_PREFIX="default"

while [ $# -gt 0 ] ; do
  nodeArg=$1
  exec< /opt/cluster/hadoop/etc/hadoop/topology.data

 result=""
 while read line ; do
 ar=( $line )
 if [ "${ar[0]}" = "$nodeArg" ] ; then
 result="${ar[1]}"
 fi
 done
 shift
 if [ -z "$result" ] ; then
 echo -n "/$RACK_PREFIX/rack "
 else
 echo -n "/$RACK_PREFIX/rack_$result "
 fi
done
