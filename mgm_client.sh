
curpath=$(dirname $(readlink -f $0 ) )

source $curpath/vars.sh


docker exec -it server ndb_mgm --ndb-connectstring=$mgmhost:1186
