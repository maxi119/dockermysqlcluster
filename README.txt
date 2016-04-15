
基本配備
RAM:       4  GB ( ndb 1.6 GB * 2 )
DISK:     10  GB


使用 build.sh 製作 mysqlcluster:7.4 的 image ( 未測試 )

第一次執行時，先修改 vars.sh 的 init_arg, 將 --initial 打開

之後依序執行
> sh start_mgm.sh
> sh start_node2.sh
> sh start_node3.sh

然後將 vars.sh 的 --initial 關掉

將初始資料複製出來
> docker cp mgm:/var/lib/mysql/ server/
> sh start_server.sh

設定 mysql, root 密碼新增帳戶
先進入 container

> docker exec -ti server bash

查看預設的 password
> cat /root/.mysql_secret
設定 root password

> mysqladmin -u root password password -p
    ( 輸入 /root/.mysql_secret 中的 password )
新增使用者
> mysql -u root -ppassword -e "Create user 'user'@'%' identified by 'passwd';"
> mysql -u root -ppassword -e "grant all on *.* to 'xy'@'%';"



=====================
如果修改了 mgm/config.ini 的參數
參考重啟需求..
http://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-params-ndbd.html
(N) 重新啟動即可，可各別重啟
(S) 全部關掉後重啟
(I) 整個 database 都需要重建, 資料會不見.

(N), (S) mgmd 啟動加上 --initial
(I) mgmd, ndbd 啟動加上 --initial .

用 mgm_client.sh 執行  ndb_mgm ( client )
