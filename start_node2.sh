
curpath=$(dirname $(readlink -f $0 ) )

source $curpath/vars.sh

nodeip=172.17.2.22
addip="ifconfig eth0 add $nodeip"
bindip="--bind-address=$nodeip"
docker run --name node2 -d --privileged \
-v $curpath/my.cnf:/etc/my.cnf \
-v $curpath/node2:/usr/local/mysql/data \
mysqlcluster:7.4 \
bash -c "$addip ; ndbd $init_arg $bindip --connect-string=host=$mgmhost:1186 --nodaemon"
