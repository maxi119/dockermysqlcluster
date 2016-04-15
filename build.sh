#! /bin/bash

curpath=$(dirname $(readlink -f $0 ) )

mkdir pkgs
cd pkgs
wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/MySQL-Cluster-gpl-7.4.10-1.el6.x86_64.rpm-bundle.tar
tar xf MySQL-Cluster-gpl-7.4.10-1.el6.x86_64.rpm-bundle.tar

cd ../

docker run -v $curpath/pkgs:/tmp/pkgs -td --name tmp centos:centos6 bash
docker exec -t tmp yum install -y perl numactl libaio
docker exec -t tmp rpm -ivh /tmp/pkgs/MySQL-Cluster-client-gpl-7.4.10-1.el6.x86_64.rpm
docker exec -t tmp rpm -ivh /tmp/pkgs/MySQL-Cluster-server-gpl-7.4.10-1.el6.x86_64.rpm

docker stop tmp
docker commit tmp mysqlcluster:7.4
docker rm tmp
