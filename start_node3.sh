
curpath=$(dirname $(readlink -f $0 ) )

source $curpath/vars.sh

nodeip=172.17.2.23
addip="ifconfig eth0 add $nodeip"
bindip="--bind-address=$nodeip"

docker run --name node3 -d --privileged \
-v $curpath/my.cnf:/etc/my.cnf \
-v $curpath/node3:/usr/local/mysql/data \
mysqlcluster:7.4 \
bash -c "$addip ; ndbd $init_arg $bindip --connect-string=host=$mgmhost:1186 --nodaemon"
