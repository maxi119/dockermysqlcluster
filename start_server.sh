
curpath=$(dirname $(readlink -f $0 ) )

source $curpath/vars.sh

docker run --name server -d \
-v $curpath/server/my.cnf:/etc/my.cnf \
-v $curpath/server/mysql:/var/lib/mysql \
-p 3306:3306 mysqlcluster:7.4 \
bash -c "ifconfig eth0 add 172.17.2.10 ;mysqld --user=mysql --server-id=1 --ndb-connectstring=$mgmhost:1186 --lc-messages-dir=/usr/share/mysql/"
