```ShellSession
$ cd ~/ghq/github.com/kotaoue/DockerHandsOn/
$ docker run -dit --name web01 -p 8080:80 httpd:2.4
eede17eeb130e31d01e94fa943dbb4389d974476602bdbb33999b80444ea46e6
$ docker run -dit --name web02 -p 8081:80 httpd:2.4
9526da19310dacc9d1cbae35580b55468d6ef9b9a10c39b635c8501063b01a71
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
9526da19310d        httpd:2.4           "httpd-foreground"   2 seconds ago       Up 2 seconds        0.0.0.0:8081->80/tcp   web02
eede17eeb130        httpd:2.4           "httpd-foreground"   16 seconds ago      Up 15 seconds       0.0.0.0:8080->80/tcp   web01
$ curl localhost:8080
<html><body><h1>It works!</h1></body></html>
$ curl localhost:8081
<html><body><h1>It works!</h1></body></html>

$ cp index.html index2.html 
$ vim index2.html 
$ docker cp index.html web01:/usr/local/apache2/htdocs/index.html
$ curl localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>

$ docker exec -it web01 /bin/bash
root@eede17eeb130:/usr/local/apache2# ls
bin  build  cgi-bin  conf  error  htdocs  icons  include  logs	modules
root@eede17eeb130:/usr/local/apache2# ls -la /usr/local/apache2/htdocs/
total 16
drwxr-xr-x 1 root     root     4096 Aug 10 23:22 .
drwxr-xr-x 1 www-data www-data 4096 Aug  5 23:21 ..
-rw-r--r-- 1      502 dialout    86 Aug  9 10:31 index.html
root@eede17eeb130:/usr/local/apache2# cat /usr/local/apache2/htdocs/index.html 
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>
root@eede17eeb130:/usr/local/apache2# exit
exit

$ docker cp index2.html web02:/usr/local/apache2/htdocs/index.html
$ curl localhost:8081
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index2.html
</body>
</html>

$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
9526da19310d        httpd:2.4           "httpd-foreground"   8 minutes ago       Up 7 minutes        0.0.0.0:8081->80/tcp   web02
eede17eeb130        httpd:2.4           "httpd-foreground"   8 minutes ago       Up 8 minutes        0.0.0.0:8080->80/tcp   web01
$ docker stop web01
web01
$ curl localhost:8080
curl: (7) Failed to connect to localhost port 8080: Connection refused

$ docker start web01
web01
$ curl localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>
$ docker stop web01
web01
$ docker rm web01
web01
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
9526da19310d        httpd:2.4           "httpd-foreground"   9 minutes ago       Up 9 minutes        0.0.0.0:8081->80/tcp   web02
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS                                NAMES
9526da19310d        httpd:2.4           "httpd-foreground"       9 minutes ago       Up 9 minutes               0.0.0.0:8081->80/tcp                 web02
$ docker run -dit --name web01 -p 8080:80 httpd:2.4
5147dfe618f075fae6f269de409fee269aef907b96a7cc963265b4f89d238f1a
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
5147dfe618f0        httpd:2.4           "httpd-foreground"   3 seconds ago       Up 2 seconds        0.0.0.0:8080->80/tcp   web01
9526da19310d        httpd:2.4           "httpd-foreground"   9 minutes ago       Up 9 minutes        0.0.0.0:8081->80/tcp   web02
$ curl localhost:8080
<html><body><h1>It works!</h1></body></html>

$ docker exec -it web01 /bin/bash 
root@5147dfe618f0:/usr/local/apache2# ls /usr/local/apache2/htdocs/
index.html
root@5147dfe618f0:/usr/local/apache2# cat /usr/local/apache2/htdocs/index.html 
<html><body><h1>It works!</h1></body></html>
root@5147dfe618f0:/usr/local/apache2# exit
exit

$ docker stop web01
web01
$ docker rm web01
web01

$ mkdir web01data
$ cp index.html web01data/index.html
$ vim web01data/index.html 

$ docker run -dit --name web01 -v web01data/:/usr/local/apache2/htdocs -p 9090:90 httpd:2.4
docker: Error response from daemon: create web01data/: "web01data/" includes invalid characters for a local volume name, only "[a-zA-Z0-9][a-zA-Z0-9_.-]" are allowed. If you intended to pass a host directory, use absolute path.
See 'docker run --help'.
$ docker run -dit --name web01 -v ./web01data/:/usr/local/apache2/htdocs -p 9090:90 httpd:2.4
docker: Error response from daemon: create ./web01data/: "./web01data/" includes invalid characters for a local volume name, only "[a-zA-Z0-9][a-zA-Z0-9_.-]" are allowed. If you intended to pass a host directory, use absolute path.
See 'docker run --help'.
$ docker run -dit --name web01 -v web01data:/usr/local/apache2/htdocs -p 9090:90 httpd:2.4
d746df07000135a44500cf4dceae1e3cb9a34a3c250afdb5b3de147878f0bee5
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                          NAMES
d746df070001        httpd:2.4           "httpd-foreground"   5 seconds ago       Up 4 seconds        80/tcp, 0.0.0.0:9090->90/tcp   web01
9526da19310d        httpd:2.4           "httpd-foreground"   15 minutes ago      Up 15 minutes       0.0.0.0:8081->80/tcp           web02
$ curl localhost:9090
curl: (52) Empty reply from server
$ docker stop web01
web01
$ docker rm web01
web01

$ echo "I'm noticed [9090:90] is wronded. correct is [9090:80]."

$ docker run -dit --name web01 -v web01data:/usr/local/apache2/htdocs -p 8080:80 httpd:2.4
4be6535dcc944a85e4e2de49ea032b53f272edd346a82928538f6ef8a248bec0
$ curl localhost:8080
<html><body><h1>It works!</h1></body></html>
$ ll
total 96
drwxr-xr-x  12 kota.oue  staff   384  8 11 08:32 .
drwxr-xr-x  12 kota.oue  staff   384  8  9 19:14 ..
drwxr-xr-x  15 kota.oue  staff   480  8 11 08:36 .git
-rw-r--r--   1 kota.oue  staff   196  8  9 19:14 README.md
-rw-r--r--   1 kota.oue  staff    99  8  9 19:18 ch-2.md
-rw-r--r--   1 kota.oue  staff  4431  8  9 20:45 ch-3.md
-rw-r--r--   1 kota.oue  staff  9557  8  9 20:56 ch-4.md
-rw-r--r--   1 kota.oue  staff  5489  8 11 08:36 ch-5.md
-rw-r--r--   1 kota.oue  staff    86  8  9 19:31 index.html
-rw-r--r--   1 kota.oue  staff    87  8 11 08:26 index2.html
-rw-r--r--   1 kota.oue  staff    72  8  9 20:50 main.go
drwxr-xr-x   3 kota.oue  staff    96  8 11 08:33 web01data
$ docker stop web01
web01
$ docker rm web01
web01

$ docker run -dit --name web01 -v ./web01data:/usr/local/apache2/htdocs -p 8080:80 httpd:2.4
docker: Error response from daemon: create ./web01data: "./web01data" includes invalid characters for a local volume name, only "[a-zA-Z0-9][a-zA-Z0-9_.-]" are allowed. If you intended to pass a host directory, use absolute path.
See 'docker run --help'.
$ docker run -dit --name web01 -v "$PWD"/web01data:/usr/local/apache2/htdocs -p 8080:80 httpd:2.4
7db59e088a88b9ee8b5262a1968e0b5b7650550510dffb72b2993d068ca7198b
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
7db59e088a88        httpd:2.4           "httpd-foreground"   7 seconds ago       Up 6 seconds        0.0.0.0:8080->80/tcp   web01
9526da19310d        httpd:2.4           "httpd-foreground"   26 minutes ago      Up 26 minutes       0.0.0.0:8081->80/tcp   web02
$ curl localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm web01data/index.html
</body>
</html>

$ docker stop web01
web01
$ docker rm web01
web01
$ docker run -dit --name web01 -v "$PWD"/web01data:/usr/local/apache2/htdocs -p 8080:80 httpd:2.4
884c68abdfbc93476fb10b11309df1911d6007ff1da96beaa93e5de450442394
$ curl localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm web01data/index.html
</body>
</html>
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
884c68abdfbc        httpd:2.4           "httpd-foreground"   33 seconds ago      Up 32 seconds       0.0.0.0:8080->80/tcp   web01
9526da19310d        httpd:2.4           "httpd-foreground"   27 minutes ago      Up 27 minutes       0.0.0.0:8081->80/tcp   web02

$ docker_search_tags mysql | grep 5.7
"name": "5.7"
"name": "5.7.10"
"name": "5.7.11"
"name": "5.7.12"
"name": "5.7.13"
"name": "5.7.14"
"name": "5.7.15"
"name": "5.7.16"
"name": "5.7.17"
"name": "5.7.18"
"name": "5.7.19"
"name": "5.7.20"
"name": "5.7.21"
"name": "5.7.22"
"name": "5.7.23"
"name": "5.7.24"
"name": "5.7.25"
"name": "5.7.26"
"name": "5.7.27"
"name": "5.7.28"
"name": "5.7.29"
"name": "5.7.30"
"name": "5.7.31"
"name": "5.7.4"
"name": "5.7.4-m14"
"name": "5.7.5"
"name": "5.7.5-m15"
"name": "5.7.6"
"name": "5.7.6-m16"
"name": "5.7.7"
"name": "5.7.7-rc"
"name": "5.7.8"
"name": "5.7.8-rc"
"name": "5.7.9"

$ docker volume create mysqlvolume
mysqlvolume
$ docker volume ls
DRIVER              VOLUME NAME
local               mysqlvolume
$ docker run --name db01 -dit -v mysqlvolume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
e7b2c287c734b1da0ef1653fbfb4f2c4388a3262d8a0d14a99d5e73bd305646f
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                 NAMES
e7b2c287c734        mysql:5.7           "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp, 33060/tcp   db01

$ docker exec -it db01 /bin/bash
root@e7b2c287c734:/# mysql -pmypassword
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.30 MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

mysql> create database exampledb;
Query OK, 1 row affected (0.00 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| exampledb          |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.01 sec)

mysql> create table examples (id int not null auto_increment, name varchar(25), primary key(id));
Query OK, 0 rows affected (0.01 sec)

mysql> show tables;
+---------------------+
| Tables_in_exampledb |
+---------------------+
| examples            |
+---------------------+
1 row in set (0.00 sec)

mysql> insert into examples values (1, 'test');
Query OK, 1 row affected (0.01 sec)

mysql> insert into examples values (2, 'test2');
Query OK, 1 row affected (0.00 sec)

mysql> select * from examples;
+----+-------+
| id | name  |
+----+-------+
|  1 | test  |
|  2 | test2 |
+----+-------+
2 rows in set (0.00 sec)

mysql> exit
Bye
root@e7b2c287c734:/# exit
exit

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
e7b2c287c734        mysql:5.7           "docker-entrypoint.s…"   7 minutes ago       Up 7 minutes        3306/tcp, 33060/tcp   db01
$ docker stop db01
db01
$ docker rm db01
db01
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS                                NAMES

$ docker run --name db01 -dit -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
1db912c7a5f00d8db3c660ec8388d35e4e63b2e6dac600eb5b08456c221c6fff
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
1db912c7a5f0        mysql:5.7           "docker-entrypoint.s…"   3 seconds ago       Up 2 seconds        3306/tcp, 33060/tcp   db01
$ docker exec -it db01 /bin/bash
root@1db912c7a5f0:/# mysql -pmypassword 
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.30 MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

mysql> exit
Bye
root@1db912c7a5f0:/# exit  
exit
$ docker stop db01
db01
$ docker rm db01
db01

$ docker run --name db01 -dit -v mysqlvolume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
e654580f371dae0b454a0ccddc6502150f29c3b46b6f1e6309886ad26a611342
$ docker exec -it db01 /bin/bash
root@e654580f371d:/# mysql -pmypassword
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.30 MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| exampledb          |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> exit
Bye
root@e654580f371d:/# exit
exit
$ docker stop db01
    db01
$ docker rm db01
db01

$ docker run --name db01 -dit -mount -type=volume,src=mysqlvolume,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
invalid argument "ount" for "-m, --memory" flag: invalid size: 'ount'
See 'docker run --help'.
$ docker run --name db01 -dit --mount type=volume,src=mysqlvolume,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
723b383394eefd5634b706e0e2542af73505db71d61be44149d4b6899202071d
$ docker exec -it db01 /bin/bash
root@723b383394ee:/# mysql -pmypassword 
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.30 MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| exampledb          |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> exit
Bye
root@723b383394ee:/# exit
exit
$ docker stop db01
db01
$ docker rm db01
db01

$ docker volume inspect mysqlvolume
[
    {
        "CreatedAt": "2020-08-12T08:32:44Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/mysqlvolume/_data",
        "Name": "mysqlvolume",
        "Options": {},
        "Scope": "local"
    }
]
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS                                NAMES

$ docker run --rm -v mysqlvolume:/src -v "$PWD":/dest busybox tar czvf /dest/backup.tar.gz -C /src .
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
61c5ed1cbdf8: Pull complete 
Digest: sha256:4f47c01fa91355af2865ac10fef5bf6ec9c7f42ad2321377c21e844427972977
Status: Downloaded newer image for busybox:latest
./
./auto.cnf
./client-key.pem
./ib_buffer_pool
./server-cert.pem
./ca.pem
./server-key.pem
./private_key.pem
./client-cert.pem
./performance_schema/
./performance_schema/events_statements_summary_by_account_by_event_name.frm
./performance_schema/events_waits_summary_by_instance.frm
./performance_schema/events_transactions_current.frm
./performance_schema/table_handles.frm
./performance_schema/events_waits_summary_by_thread_by_event_name.frm
./performance_schema/session_connect_attrs.frm
./performance_schema/replication_applier_status_by_worker.frm
./performance_schema/performance_timers.frm
./performance_schema/file_summary_by_event_name.frm
./performance_schema/events_transactions_summary_global_by_event_name.frm
./performance_schema/events_waits_summary_by_host_by_event_name.frm
./performance_schema/memory_summary_global_by_event_name.frm
./performance_schema/session_variables.frm
./performance_schema/events_waits_summary_global_by_event_name.frm
./performance_schema/setup_objects.frm
./performance_schema/events_stages_summary_global_by_event_name.frm
./performance_schema/events_transactions_summary_by_host_by_event_name.frm
./performance_schema/replication_connection_configuration.frm
./performance_schema/setup_instruments.frm
./performance_schema/table_io_waits_summary_by_index_usage.frm
./performance_schema/events_statements_summary_by_host_by_event_name.frm
./performance_schema/hosts.frm
./performance_schema/replication_group_member_stats.frm
./performance_schema/events_waits_summary_by_account_by_event_name.frm
./performance_schema/events_statements_summary_by_thread_by_event_name.frm
./performance_schema/events_statements_current.frm
./performance_schema/global_variables.frm
./performance_schema/events_waits_history_long.frm
./performance_schema/setup_timers.frm
./performance_schema/prepared_statements_instances.frm
./performance_schema/setup_consumers.frm
./performance_schema/metadata_locks.frm
./performance_schema/file_instances.frm
./performance_schema/users.frm
./performance_schema/events_transactions_summary_by_thread_by_event_name.frm
./performance_schema/status_by_account.frm
./performance_schema/events_stages_summary_by_user_by_event_name.frm
./performance_schema/events_transactions_summary_by_user_by_event_name.frm
./performance_schema/session_status.frm
./performance_schema/setup_actors.frm
./performance_schema/events_waits_current.frm
./performance_schema/events_stages_history.frm
./performance_schema/events_stages_summary_by_host_by_event_name.frm
./performance_schema/accounts.frm
./performance_schema/socket_instances.frm
./performance_schema/memory_summary_by_thread_by_event_name.frm
./performance_schema/socket_summary_by_instance.frm
./performance_schema/threads.frm
./performance_schema/session_account_connect_attrs.frm
./performance_schema/user_variables_by_thread.frm
./performance_schema/status_by_host.frm
./performance_schema/events_waits_summary_by_user_by_event_name.frm
./performance_schema/events_statements_history_long.frm
./performance_schema/replication_applier_status_by_coordinator.frm
./performance_schema/events_waits_history.frm
./performance_schema/events_statements_summary_by_user_by_event_name.frm
./performance_schema/events_statements_summary_global_by_event_name.frm
./performance_schema/table_io_waits_summary_by_table.frm
./performance_schema/events_statements_summary_by_program.frm
./performance_schema/variables_by_thread.frm
./performance_schema/status_by_user.frm
./performance_schema/events_stages_summary_by_thread_by_event_name.frm
./performance_schema/memory_summary_by_host_by_event_name.frm
./performance_schema/events_stages_history_long.frm
./performance_schema/events_transactions_summary_by_account_by_event_name.frm
./performance_schema/replication_connection_status.frm
./performance_schema/db.opt
./performance_schema/rwlock_instances.frm
./performance_schema/replication_group_members.frm
./performance_schema/host_cache.frm
./performance_schema/replication_applier_status.frm
./performance_schema/events_statements_history.frm
./performance_schema/objects_summary_global_by_type.frm
./performance_schema/status_by_thread.frm
./performance_schema/table_lock_waits_summary_by_table.frm
./performance_schema/events_stages_current.frm
./performance_schema/replication_applier_configuration.frm
./performance_schema/global_status.frm
./performance_schema/cond_instances.frm
./performance_schema/events_statements_summary_by_digest.frm
./performance_schema/events_stages_summary_by_account_by_event_name.frm
./performance_schema/mutex_instances.frm
./performance_schema/socket_summary_by_event_name.frm
./performance_schema/memory_summary_by_user_by_event_name.frm
./performance_schema/events_transactions_history.frm
./performance_schema/events_transactions_history_long.frm
./performance_schema/file_summary_by_instance.frm
./performance_schema/memory_summary_by_account_by_event_name.frm
./mysql/
./mysql/time_zone_transition.frm
./mysql/columns_priv.MYD
./mysql/slow_log.frm
./mysql/time_zone_transition_type.frm
./mysql/proxies_priv.MYD
./mysql/procs_priv.frm
./mysql/gtid_executed.frm
./mysql/innodb_index_stats.ibd
./mysql/slave_master_info.ibd
./mysql/slave_relay_log_info.ibd
./mysql/innodb_table_stats.ibd
./mysql/slave_relay_log_info.frm
./mysql/db.MYI
./mysql/general_log.CSV
./mysql/time_zone_name.ibd
./mysql/help_relation.ibd
./mysql/slave_worker_info.frm
./mysql/user.frm
./mysql/ndb_binlog_index.MYI
./mysql/help_keyword.frm
./mysql/time_zone.frm
./mysql/ndb_binlog_index.frm
./mysql/time_zone_transition_type.ibd
./mysql/innodb_index_stats.frm
./mysql/user.MYD
./mysql/procs_priv.MYD
./mysql/slave_worker_info.ibd
./mysql/help_category.ibd
./mysql/help_topic.ibd
./mysql/proxies_priv.frm
./mysql/help_keyword.ibd
./mysql/tables_priv.MYI
./mysql/gtid_executed.ibd
./mysql/procs_priv.MYI
./mysql/event.frm
./mysql/columns_priv.frm
./mysql/ndb_binlog_index.MYD
./mysql/general_log.CSM
./mysql/time_zone.ibd
./mysql/time_zone_name.frm
./mysql/engine_cost.frm
./mysql/tables_priv.MYD
./mysql/columns_priv.MYI
./mysql/plugin.frm
./mysql/event.MYI
./mysql/proxies_priv.MYI
./mysql/proc.MYI
./mysql/db.frm
./mysql/db.MYD
./mysql/help_topic.frm
./mysql/func.frm
./mysql/proc.frm
./mysql/slave_master_info.frm
./mysql/time_zone_leap_second.frm
./mysql/tables_priv.frm
./mysql/help_relation.frm
./mysql/func.MYD
./mysql/general_log.frm
./mysql/slow_log.CSV
./mysql/servers.frm
./mysql/engine_cost.ibd
./mysql/help_category.frm
./mysql/db.opt
./mysql/time_zone_leap_second.ibd
./mysql/server_cost.frm
./mysql/user.MYI
./mysql/func.MYI
./mysql/plugin.ibd
./mysql/innodb_table_stats.frm
./mysql/time_zone_transition.ibd
./mysql/servers.ibd
./mysql/slow_log.CSM
./mysql/event.MYD
./mysql/proc.MYD
./mysql/server_cost.ibd
./ibdata1
./public_key.pem
./exampledb/
./exampledb/examples.ibd
./exampledb/examples.frm
./exampledb/db.opt
./ib_logfile1
./ca-key.pem
./sys/
./sys/x@0024wait_classes_global_by_latency.frm
./sys/schema_table_lock_waits.frm
./sys/memory_by_host_by_current_bytes.frm
./sys/version.frm
./sys/x@0024memory_global_by_current_bytes.frm
./sys/sys_config_insert_set_user.TRN
./sys/x@0024waits_by_user_by_latency.frm
./sys/metrics.frm
./sys/x@0024innodb_buffer_stats_by_schema.frm
./sys/statements_with_full_table_scans.frm
./sys/x@0024host_summary_by_statement_type.frm
./sys/host_summary.frm
./sys/statement_analysis.frm
./sys/x@0024io_global_by_wait_by_bytes.frm
./sys/innodb_lock_waits.frm
./sys/memory_by_thread_by_current_bytes.frm
./sys/x@0024statements_with_temp_tables.frm
./sys/x@0024statement_analysis.frm
./sys/memory_global_by_current_bytes.frm
./sys/x@0024schema_table_statistics_with_buffer.frm
./sys/x@0024memory_by_host_by_current_bytes.frm
./sys/x@0024user_summary_by_statement_type.frm
./sys/innodb_buffer_stats_by_table.frm
./sys/x@0024io_by_thread_by_latency.frm
./sys/sys_config.TRG
./sys/waits_global_by_latency.frm
./sys/x@0024ps_schema_table_statistics_io.frm
./sys/user_summary.frm
./sys/sys_config.frm
./sys/schema_table_statistics_with_buffer.frm
./sys/schema_object_overview.frm
./sys/session.frm
./sys/x@0024statements_with_runtimes_in_95th_percentile.frm
./sys/x@0024host_summary_by_file_io_type.frm
./sys/statements_with_runtimes_in_95th_percentile.frm
./sys/io_by_thread_by_latency.frm
./sys/x@0024latest_file_io.frm
./sys/schema_table_statistics.frm
./sys/waits_by_host_by_latency.frm
./sys/io_global_by_file_by_latency.frm
./sys/x@0024wait_classes_global_by_avg_latency.frm
./sys/x@0024memory_by_user_by_current_bytes.frm
./sys/processlist.frm
./sys/user_summary_by_statement_type.frm
./sys/x@0024host_summary_by_file_io.frm
./sys/x@0024ps_digest_avg_latency_distribution.frm
./sys/x@0024waits_global_by_latency.frm
./sys/schema_redundant_indexes.frm
./sys/x@0024innodb_buffer_stats_by_table.frm
./sys/x@0024memory_by_thread_by_current_bytes.frm
./sys/statements_with_temp_tables.frm
./sys/statements_with_errors_or_warnings.frm
./sys/x@0024host_summary_by_stages.frm
./sys/x@0024user_summary_by_file_io.frm
./sys/wait_classes_global_by_latency.frm
./sys/wait_classes_global_by_avg_latency.frm
./sys/host_summary_by_file_io_type.frm
./sys/x@0024innodb_lock_waits.frm
./sys/schema_auto_increment_columns.frm
./sys/x@0024memory_global_total.frm
./sys/io_global_by_wait_by_bytes.frm
./sys/x@0024host_summary_by_statement_latency.frm
./sys/x@0024schema_table_statistics.frm
./sys/x@0024user_summary_by_file_io_type.frm
./sys/memory_by_user_by_current_bytes.frm
./sys/x@0024schema_flattened_keys.frm
./sys/schema_unused_indexes.frm
./sys/x@0024statements_with_errors_or_warnings.frm
./sys/user_summary_by_file_io_type.frm
./sys/waits_by_user_by_latency.frm
./sys/user_summary_by_stages.frm
./sys/session_ssl_status.frm
./sys/memory_global_total.frm
./sys/user_summary_by_file_io.frm
./sys/x@0024schema_tables_with_full_table_scans.frm
./sys/sys_config_update_set_user.TRN
./sys/x@0024io_global_by_file_by_bytes.frm
./sys/schema_tables_with_full_table_scans.frm
./sys/x@0024waits_by_host_by_latency.frm
./sys/x@0024user_summary.frm
./sys/io_global_by_wait_by_latency.frm
./sys/x@0024statements_with_full_table_scans.frm
./sys/db.opt
./sys/latest_file_io.frm
./sys/io_global_by_file_by_bytes.frm
./sys/x@0024schema_table_lock_waits.frm
./sys/host_summary_by_statement_type.frm
./sys/x@0024session.frm
./sys/host_summary_by_statement_latency.frm
./sys/x@0024statements_with_sorting.frm
./sys/x@0024host_summary.frm
./sys/host_summary_by_stages.frm
./sys/x@0024ps_digest_95th_percentile_by_avg_us.frm
./sys/x@0024processlist.frm
./sys/x@0024io_global_by_file_by_latency.frm
./sys/statements_with_sorting.frm
./sys/x@0024user_summary_by_statement_latency.frm
./sys/schema_index_statistics.frm
./sys/x@0024io_global_by_wait_by_latency.frm
./sys/user_summary_by_statement_latency.frm
./sys/ps_check_lost_instrumentation.frm
./sys/x@0024schema_index_statistics.frm
./sys/sys_config.ibd
./sys/x@0024user_summary_by_stages.frm
./sys/innodb_buffer_stats_by_schema.frm
./sys/host_summary_by_file_io.frm
./ib_logfile0

$ ls -la | grep *.gz
-rw-r--r--   1 kota.oue  staff  7146104  8 12 17:45 backup.tar.gz
$ tar tzvf backup.tar.gz | head
drwxr-xr-x  0 999    999         0  8 12 17:32 ./
-rw-r-----  0 999    999        56  8 12 17:00 ./auto.cnf
-rw-------  0 999    999      1680  8 12 17:00 ./client-key.pem
-rw-r-----  0 999    999       403  8 12 17:32 ./ib_buffer_pool
-rw-r--r--  0 999    999      1112  8 12 17:00 ./server-cert.pem
-rw-r--r--  0 999    999      1112  8 12 17:00 ./ca.pem
-rw-------  0 999    999      1676  8 12 17:00 ./server-key.pem
-rw-------  0 999    999      1680  8 12 17:00 ./private_key.pem
-rw-r--r--  0 999    999      1112  8 12 17:00 ./client-cert.pem
drwxr-x---  0 999    999         0  8 12 17:00 ./performance_schema/

$ docker volume rm mysqlvolume
mysqlvolume
$ docker volume ls
DRIVER              VOLUME NAME
$ docker volume create mysqlvolume
mysqlvolume
$ docker volume ls
DRIVER              VOLUME NAME
local               mysqlvolume

$ docker run --rm -v mysqlvolume:/dest -v "$PWD":/src busybox tar xzf /src/backup.tar.gz -C /dest
$ docker volume inspect mysqlvolume
[
    {
        "CreatedAt": "2020-08-12T08:53:33Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/mysqlvolume/_data",
        "Name": "mysqlvolume",
        "Options": {},
        "Scope": "local"
    }
]

$ docker run --name db01 -dit --mount type=volume,src=mysqlvolume,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
70ea0cb1d4024b882fe2c4eb0482ef288e15c7b0a01877663eb32af14de7b8b3
$ docker exec -it db01 /bin/bash
root@70ea0cb1d402:/# mysql -pmypassword
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.30 MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| exampledb          |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> exit
Bye
root@70ea0cb1d402:/# exit
exit
$ docker stop db01
db01
$ docker rm db01
db01

$ docker run --name db01 -dit --mount type=volume,src=mysqlvolume,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.7
$ docker run --rm --volumes-from db01 -v "$PWD":/dest busybox tar czf /dest/backup.tar.gz -C /var/lib/mysql .
```