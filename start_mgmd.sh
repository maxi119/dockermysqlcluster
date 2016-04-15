
curpath=$(dirname $(readlink -f $0 ) )

source $curpath/vars.sh
addip="ifconfig eth0 add $mgmhost"

init=
#init=--initial
docker run --name mgm -d --privileged \
-v $curpath/mgm:/var/lib/mysql-cluster \
-v $curpath/mgm/userdata:/usr/mysql-cluster \
mysqlcluster:7.4 \
bash -c "$addip; ndb_mgmd -f /var/lib/mysql-cluster/config.ini --nodaemon $init"

echo Mgm ip address: 
docker inspect --format '{{ .NetworkSettings.IPAddress }}' mgm
