```ShellSession
$ cd ~/ghq/github.com/kotaoue/DockerHandsOn/

$ docker image rm mysql:5.7
Untagged: mysql:5.7
Untagged: mysql@sha256:32f9d9a069f7a735e28fd44ea944d53c61f990ba71460c5c183e610854ca4854
Deleted: sha256:9cfcce23593a93135ca6dbf3ed544d1db9324d4c40b5c0d56958165bfaa2d46a
Deleted: sha256:98de3e212919056def8c639045293658f6e6022794807d4b0126945ddc8324be
Deleted: sha256:17e8b88858e400f8c5e10e7cb3fbab9477f6d8aacba03b8167d34a91dbe4d8c1
Deleted: sha256:c04c087c2af9abd64ba32fe89d65e6d83da514758923de5da154541cc01a3a1e
Deleted: sha256:ab8bf065b402b99aec4f12c648535ef1b8dc954b4e1773bdffa10ae2027d3e00
Deleted: sha256:09687cd9cdf4c704fde969fdba370c2d848bc614689712bef1a31d0d581f2007
Deleted: sha256:b704a4a65bf536f82e5d8b86e633d19185e26313de8380162e778feb2852011a
Deleted: sha256:c37206160543786228aa0cce738e85343173851faa44bb4dc07dc9b7dc4ff1c1
Deleted: sha256:12912c9ec523f648130e663d9d4f0a47c1841a0064d4152bcf7b2a97f96326eb
Deleted: sha256:57d29ad88aa49f0f439592755722e70710501b366e2be6125c95accc43464844
Deleted: sha256:b17c024283d0302615c6f0c825137da9db607d49a83d2215a79733afbbaeb7c3
Deleted: sha256:13cb14c2acd34e45446a50af25cb05095a17624678dbafbcc9e26086547c1d74
$ docker pull mysql:5.7
5.7: Pulling from library/mysql
bf5952930446: Already exists 
8254623a9871: Pull complete 
938e3e06dac4: Pull complete 
ea28ebf28884: Pull complete 
f3cef38785c2: Pull complete 
894f9792565a: Pull complete 
1d8a57523420: Pull complete 
5f09bf1d31c1: Pull complete 
1b6ff254abe7: Pull complete 
74310a0bf42d: Pull complete 
d398726627fd: Pull complete 
Digest: sha256:da58f943b94721d46e87d5de208dc07302a8b13e638cd1d24285d222376d6d84
Status: Downloaded newer image for mysql:5.7
docker.io/library/mysql:5.7
$ docker history ysql:5/7
Error response from daemon: No such image: ysql:5/7:latest
$ docker history mysql:5.7
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
718a6da099d8        9 days ago          /bin/sh -c #(nop)  CMD ["mysqld"]               0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  EXPOSE 3306 33060            0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B                  
<missing>           9 days ago          /bin/sh -c ln -s usr/local/bin/docker-entryp…   34B                 
<missing>           9 days ago          /bin/sh -c #(nop) COPY file:7cbb26bbdb8e71b3…   13.2kB              
<missing>           9 days ago          /bin/sh -c #(nop)  VOLUME [/var/lib/mysql]      0B                  
<missing>           9 days ago          /bin/sh -c {   echo mysql-community-server m…   313MB               
<missing>           9 days ago          /bin/sh -c echo "deb http://repo.mysql.com/a…   55B                 
<missing>           9 days ago          /bin/sh -c #(nop)  ENV MYSQL_VERSION=5.7.31-…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  ENV MYSQL_MAJOR=5.7          0B                  
<missing>           9 days ago          /bin/sh -c set -ex;  key='A4A9406876FCBD3C45…   2.61kB              
<missing>           9 days ago          /bin/sh -c apt-get update && apt-get install…   52.2MB              
<missing>           9 days ago          /bin/sh -c mkdir /docker-entrypoint-initdb.d    0B                  
<missing>           9 days ago          /bin/sh -c set -eux;  savedAptMark="$(apt-ma…   4.17MB              
<missing>           9 days ago          /bin/sh -c #(nop)  ENV GOSU_VERSION=1.12        0B                  
<missing>           9 days ago          /bin/sh -c apt-get update && apt-get install…   9.34MB              
<missing>           9 days ago          /bin/sh -c groupadd -r mysql && useradd -r -…   329kB               
<missing>           9 days ago          /bin/sh -c #(nop)  CMD ["bash"]                 0B                  
<missing>           9 days ago          /bin/sh -c #(nop) ADD file:3af3091e7d2bb40bc…   69.2MB  

$ docker run -dit --name webcontet -p 8080:80 httpd:2.4
652adaf9d269afac7ddfb45f8e1ffce27255d0a25edbb9520b38b29a14d5da6b
$ docker cp index.html webcontet:/usr/local/apache2/htdocs
$ curl http://localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>

$ docker commit webcontet mycustomed_httpd
sha256:1f517ea946fc90c29e7117a5a0c1061a168845b4778f70dbee47cb8c136ec7b2
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mycustomed_httpd    latest              1f517ea946fc        7 seconds ago       166MB

$ docker image history mycustomed_httpd
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
1f517ea946fc        44 seconds ago      httpd-foreground                                88B                 
a6ea92c35c43        8 days ago          /bin/sh -c #(nop)  CMD ["httpd-foreground"]     0B                  
<missing>           8 days ago          /bin/sh -c #(nop)  EXPOSE 80                    0B                  
<missing>           8 days ago          /bin/sh -c #(nop) COPY file:c432ff61c4993ecd…   138B                
<missing>           8 days ago          /bin/sh -c #(nop)  STOPSIGNAL SIGWINCH          0B                  
<missing>           8 days ago          /bin/sh -c set -eux;   savedAptMark="$(apt-m…   61MB                
<missing>           8 days ago          /bin/sh -c #(nop)  ENV HTTPD_PATCHES=           0B                  
<missing>           8 days ago          /bin/sh -c #(nop)  ENV HTTPD_SHA256=740eddf6…   0B                  
<missing>           8 days ago          /bin/sh -c #(nop)  ENV HTTPD_VERSION=2.4.46     0B                  
<missing>           9 days ago          /bin/sh -c set -eux;  apt-get update;  apt-g…   35.4MB              
<missing>           9 days ago          /bin/sh -c #(nop) WORKDIR /usr/local/apache2    0B                  
<missing>           9 days ago          /bin/sh -c mkdir -p "$HTTPD_PREFIX"  && chow…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  ENV PATH=/usr/local/apach…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  ENV HTTPD_PREFIX=/usr/loc…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  CMD ["bash"]                 0B                  
<missing>           9 days ago          /bin/sh -c #(nop) ADD file:3af3091e7d2bb40bc…   69.2MB   

$ docker run -dit --name webcontent_new -p 8081:80 mycustomed_httpd
7a97f16dde8660129b7d66e88762299195be9d7a9602e1c890fc36ea7b054bee
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
7a97f16dde86        mycustomed_httpd    "httpd-foreground"   2 seconds ago       Up 2 seconds        0.0.0.0:8081->80/tcp   webcontent_new
652adaf9d269        httpd:2.4           "httpd-foreground"   3 minutes ago       Up 3 minutes        0.0.0.0:8080->80/tcp   webcontet
$ docker exec -it webcontent_new /bin/bash
root@7a97f16dde86:/usr/local/apache2# cd /usr/local/apache2/htdocs/
root@7a97f16dde86:/usr/local/apache2/htdocs# ls -la
total 16
drwxr-xr-x 1 root     root     4096 Aug 14 13:36 .
drwxr-xr-x 1 www-data www-data 4096 Aug  5 23:21 ..
-rw-r--r-- 1      502 dialout    86 Aug  9 10:31 index.html
root@7a97f16dde86:/usr/local/apache2/htdocs# cat index.html 
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>
root@7a97f16dde86:/usr/local/apache2/htdocs# exit
exit
$ curl http://localhost:8081
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>

$ docker stop webcontet webcontet
webcontet
webcontet
$ docker rm webcontet webcontet
webcontet
Error response from daemon: removal of container webcontet is already in progress
$ docker stop webcontet webcontet_new
Error response from daemon: No such container: webcontet
Error response from daemon: No such container: webcontet_new
$ docker stop webcontet webcontent_new
webcontent_new
Error response from daemon: No such container: webcontet
$ docker rm webcontet webcontent_new
webcontent_new
Error: No such container: webcontet
$ docker image rm mycustomed_httpd
Untagged: mycustomed_httpd:latest
Deleted: sha256:1f517ea946fc90c29e7117a5a0c1061a168845b4778f70dbee47cb8c136ec7b2
Deleted: sha256:ad8102bd7f27aba602831422007607c0dd84a035dc987534c0d0fa2de865568d

$ mkdir customed_httpd
$ cd customed_httpd/
$ ll
total 0
drwxr-xr-x   2 kota.oue  staff   64  8 14 22:43 .
drwxr-xr-x  18 kota.oue  staff  576  8 14 22:43 ..
$ cp ../index.html index.html
$ ll
total 8
drwxr-xr-x   3 kota.oue  staff   96  8 14 22:44 .
drwxr-xr-x  18 kota.oue  staff  576  8 14 22:43 ..
-rw-r--r--   1 kota.oue  staff   86  8 14 22:44 index.html

$ touch Dockerfile
$ docker build -t myimage01 .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM httpd
latest: Pulling from library/httpd
Digest: sha256:3cbdff4bc16681541885ccf1524a532afa28d2a6578ab7c2d5154a7abc182379
Status: Downloaded newer image for httpd:latest
 ---> a6ea92c35c43
Step 2/2 : COPY index.html /usr/local/apache2/htdocs
 ---> be172496cc27
Successfully built be172496cc27
Successfully tagged myimage01:latest
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
myimage01           latest              be172496cc27        5 seconds ago       166MB
$ docker history myimage01
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
be172496cc27        14 seconds ago      /bin/sh -c #(nop) COPY file:eb5f451621c7d777…   86B                 
a6ea92c35c43        8 days ago          /bin/sh -c #(nop)  CMD ["httpd-foreground"]     0B                  
<missing>           8 days ago          /bin/sh -c #(nop)  EXPOSE 80                    0B                  
<missing>           8 days ago          /bin/sh -c #(nop) COPY file:c432ff61c4993ecd…   138B                
<missing>           8 days ago          /bin/sh -c #(nop)  STOPSIGNAL SIGWINCH          0B                  
<missing>           8 days ago          /bin/sh -c set -eux;   savedAptMark="$(apt-m…   61MB                
<missing>           8 days ago          /bin/sh -c #(nop)  ENV HTTPD_PATCHES=           0B                  
<missing>           8 days ago          /bin/sh -c #(nop)  ENV HTTPD_SHA256=740eddf6…   0B                  
<missing>           8 days ago          /bin/sh -c #(nop)  ENV HTTPD_VERSION=2.4.46     0B                  
<missing>           9 days ago          /bin/sh -c set -eux;  apt-get update;  apt-g…   35.4MB              
<missing>           9 days ago          /bin/sh -c #(nop) WORKDIR /usr/local/apache2    0B                  
<missing>           9 days ago          /bin/sh -c mkdir -p "$HTTPD_PREFIX"  && chow…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  ENV PATH=/usr/local/apach…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  ENV HTTPD_PREFIX=/usr/loc…   0B                  
<missing>           9 days ago          /bin/sh -c #(nop)  CMD ["bash"]                 0B                  
<missing>           9 days ago          /bin/sh -c #(nop) ADD file:3af3091e7d2bb40bc…   69.2MB   

$ docker run -dit --name webcontent_docker -p 8080:80 myimage01
60a3fdc8db0f35ca96e31577f9e9ca24cc77dee8f321a13bd028bad890636900
$ curl http://localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>

$ docker stop webcontet_docker
Error response from daemon: No such container: webcontet_docker
$ docker stop webcontent_docker
webcontent_docker
$ docker rm webcontent_docker
webcontent_docker
$ docker image rm myimage01
Untagged: myimage01:latest
Deleted: sha256:be172496cc274cbcf779d365adbc15fefc3920481605ab1bddeb4d8446c30dba
Deleted: sha256:6e61caaaae8c80d62bbc688309a173b14609b118777340c00d1f24ecb570c16c

$ curl -s https://github.com/docker-library/httpd/tree/master/2.4 | head





<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
  <link rel="dns-prefetch" href="https://github.githubassets.com">

$ cd ..
$ mkdir phpimage
$ cd phpimage/

$ touch index.php
$ touch Dockerfile

$ docker build . -t myphpimage
Sending build context to Docker daemon  3.072kB
Step 1/5 : FROM debian
latest: Pulling from library/debian
d6ff36c9ec48: Already exists 
Digest: sha256:1e74c92df240634a39d050a5e23fb18f45df30846bb222f543414da180b47a5d
Status: Downloaded newer image for debian:latest
 ---> ee11c54e6bb7
Step 2/5 : EXPOSE 80
 ---> Running in e7208146dfff
Removing intermediate container e7208146dfff
 ---> 9fafd184042b
Step 3/5 : RUN apt update     && apt install -y apache2 php libapache-mod-php     && apt clean     && rm -rf /var/lib/apt/lists/*     && rm /var/www/htmo/index.html
 ---> Running in ebb69d6f9bb9

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Get:1 http://deb.debian.org/debian buster InRelease [122 kB]
Get:2 http://deb.debian.org/debian buster-updates InRelease [51.9 kB]
Get:3 http://deb.debian.org/debian buster/main amd64 Packages [7906 kB]
Get:4 http://security.debian.org/debian-security buster/updates InRelease [65.4 kB]
Get:5 http://security.debian.org/debian-security buster/updates/main amd64 Packages [218 kB]
Get:6 http://deb.debian.org/debian buster-updates/main amd64 Packages [7868 B]
Fetched 8372 kB in 3s (3324 kB/s)
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
E: Unable to locate package libapache-mod-php
The command '/bin/sh -c apt update     && apt install -y apache2 php libapache-mod-php     && apt clean     && rm -rf /var/lib/apt/lists/*     && rm /var/www/htmo/index.html' returned a non-zero code: 100


$ docker build . -t myphpimage
WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

rm: cannot remove '/var/www/htmo/index.html': No such file or directory
The command '/bin/sh -c apt update     && apt install -y apache2 php libapache2-mod-php     && apt clean     && rm -rf /var/lib/apt/lists/*     && rm /var/www/htmo/index.html' returned a non-zero code: 1

$ docker build . -t myphpimage
Successfully built 44600250d509
Successfully tagged myphpimage:latest

$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
myphpimage          latest              44600250d509        48 seconds ago      245MB

$ docker run -dit --name myphp -p 8080:80 myphpimage
bc433df6a8626de4da191a1f20f179c670218840fd419400e6b14d483c648357
$ curl http://localhost:8080
<html>
<head><title>TestPage</title></head>
<body>
<pre>
array(26) {
  ["HTTP_HOST"]=>
  string(14) "localhost:8080"
  ["HTTP_USER_AGENT"]=>
  string(11) "curl/7.64.1"
  ["HTTP_ACCEPT"]=>
  string(3) "*/*"
  ["PATH"]=>
  string(60) "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  ["SERVER_SIGNATURE"]=>
  string(72) "<address>Apache/2.4.38 (Debian) Server at localhost Port 8080</address>
"
  ["SERVER_SOFTWARE"]=>
  string(22) "Apache/2.4.38 (Debian)"
  ["SERVER_NAME"]=>
  string(9) "localhost"
  ["SERVER_ADDR"]=>
  string(10) "172.17.0.2"
  ["SERVER_PORT"]=>
  string(4) "8080"
  ["REMOTE_ADDR"]=>
  string(10) "172.17.0.1"
  ["DOCUMENT_ROOT"]=>
  string(13) "/var/www/html"
  ["REQUEST_SCHEME"]=>
  string(4) "http"
  ["CONTEXT_PREFIX"]=>
  string(0) ""
  ["CONTEXT_DOCUMENT_ROOT"]=>
  string(13) "/var/www/html"
  ["SERVER_ADMIN"]=>
  string(19) "webmaster@localhost"
  ["SCRIPT_FILENAME"]=>
  string(23) "/var/www/html/index.php"
  ["REMOTE_PORT"]=>
  string(5) "45446"
  ["GATEWAY_INTERFACE"]=>
  string(7) "CGI/1.1"
  ["SERVER_PROTOCOL"]=>
  string(8) "HTTP/1.1"
  ["REQUEST_METHOD"]=>
  string(3) "GET"
  ["QUERY_STRING"]=>
  string(0) ""
  ["REQUEST_URI"]=>
  string(1) "/"
  ["SCRIPT_NAME"]=>
  string(10) "/index.php"
  ["PHP_SELF"]=>
  string(10) "/index.php"
  ["REQUEST_TIME_FLOAT"]=>
  float(1597414146.779)
  ["REQUEST_TIME"]=>
  int(1597414146)
}
</pre>
</body>
</html>

$ docker stop myphp
myphp
$ docker rm myphp
myphp

$ docker save -o saved.tar myphpimage
$ ls -la saved.tar 
-rw-------  1 kota.oue  staff  253560832  8 14 23:12 saved.tar
$ tar tvf saved.tar 
drwxr-xr-x  0 0      0           0  8 14 23:11 0311969260b1efb38d70b8808b08f760bfe18acb42441fea00d35885ee9b0b6c/
-rw-r--r--  0 0      0           3  8 14 23:11 0311969260b1efb38d70b8808b08f760bfe18acb42441fea00d35885ee9b0b6c/VERSION
-rw-r--r--  0 0      0         477  8 14 23:11 0311969260b1efb38d70b8808b08f760bfe18acb42441fea00d35885ee9b0b6c/json
-rw-r--r--  0 0      0   134319616  8 14 23:11 0311969260b1efb38d70b8808b08f760bfe18acb42441fea00d35885ee9b0b6c/layer.tar
drwxr-xr-x  0 0      0           0  8 14 23:11 06620b72e8603dc58fb74a7b73c3bbc82f073b909b6e0e2b8d517e9a7a809c14/
-rw-r--r--  0 0      0           3  8 14 23:11 06620b72e8603dc58fb74a7b73c3bbc82f073b909b6e0e2b8d517e9a7a809c14/VERSION
-rw-r--r--  0 0      0        1407  8 14 23:11 06620b72e8603dc58fb74a7b73c3bbc82f073b909b6e0e2b8d517e9a7a809c14/json
-rw-r--r--  0 0      0        3584  8 14 23:11 06620b72e8603dc58fb74a7b73c3bbc82f073b909b6e0e2b8d517e9a7a809c14/layer.tar
drwxr-xr-x  0 0      0           0  8 14 23:11 78c2c599cff6609cf58f5f502daa7e4ecca6d413171bc03cedfdc4a8dda07033/
-rw-r--r--  0 0      0           3  8 14 23:11 78c2c599cff6609cf58f5f502daa7e4ecca6d413171bc03cedfdc4a8dda07033/VERSION
-rw-r--r--  0 0      0         401  8 14 23:11 78c2c599cff6609cf58f5f502daa7e4ecca6d413171bc03cedfdc4a8dda07033/json
-rw-r--r--  0 0      0   119220736  8 14 23:11 78c2c599cff6609cf58f5f502daa7e4ecca6d413171bc03cedfdc4a8dda07033/layer.tar
-rw-r--r--  0 0      0        2612  8 14 23:11 cb9ceebdc7f3daeaf8d04804395bd5c96b27f3e9e03adb8c5969cf7dfb8bb3a4.json
-rw-r--r--  0 0      0         360  1  1  1970 manifest.json
-rw-r--r--  0 0      0          93  1  1  1970 repositories

$ docker image rm myphpimage
Untagged: myphpimage:latest
Deleted: sha256:cb9ceebdc7f3daeaf8d04804395bd5c96b27f3e9e03adb8c5969cf7dfb8bb3a4
Deleted: sha256:1b10000ad457d2d50a9bf39aaf09a917382810fb8f2285d295aadd32c81ae2ee
Deleted: sha256:cbe0c3fd50a109ebc5e7f4df1d3939f523948332fe0de9d1dd99fbec91443605
Deleted: sha256:cb69998a45da709e0b597c4ccbbec3e57be0a5c5fe8d62f9a90502e7bc48e6a3
Deleted: sha256:60ba9a83639bda53cca8afd090456b3f5a014afb70842060e52d84b34cf8e821
Deleted: sha256:2351d7772bd6bedc1967240efdd556821dacf2d522c38465f709558316f81470
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE

$ docker load -i saved.tar 
37f354a60981: Loading layer [==================================================>]  134.3MB/134.3MB
3435096d8215: Loading layer [==================================================>]  3.584kB/3.584kB
Loaded image: myphpimage:latest
$ docker image ls | grep myphpimage
myphpimage          latest              cb9ceebdc7f3        4 minutes ago       245MB

$ docker run -dit --name myphp02 -p 8080:80 myphpimage
f00b8eed2a246fd4dd3913676f9dc0ad3df52e14ec741075d504197458bc0a9f
$ curl http://localhost:8080
<html>
<head><title>TestPage</title></head>
<body>
<pre>
array(26) {
  ["HTTP_HOST"]=>
  string(14) "localhost:8080"
  ["HTTP_USER_AGENT"]=>
  string(11) "curl/7.64.1"
  ["HTTP_ACCEPT"]=>
  string(3) "*/*"
  ["PATH"]=>
  string(60) "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  ["SERVER_SIGNATURE"]=>
  string(72) "<address>Apache/2.4.38 (Debian) Server at localhost Port 8080</address>
"
  ["SERVER_SOFTWARE"]=>
  string(22) "Apache/2.4.38 (Debian)"
  ["SERVER_NAME"]=>
  string(9) "localhost"
  ["SERVER_ADDR"]=>
  string(10) "172.17.0.2"
  ["SERVER_PORT"]=>
  string(4) "8080"
  ["REMOTE_ADDR"]=>
  string(10) "172.17.0.1"
  ["DOCUMENT_ROOT"]=>
  string(13) "/var/www/html"
  ["REQUEST_SCHEME"]=>
  string(4) "http"
  ["CONTEXT_PREFIX"]=>
  string(0) ""
  ["CONTEXT_DOCUMENT_ROOT"]=>
  string(13) "/var/www/html"
  ["SERVER_ADMIN"]=>
  string(19) "webmaster@localhost"
  ["SCRIPT_FILENAME"]=>
  string(23) "/var/www/html/index.php"
  ["REMOTE_PORT"]=>
  string(5) "45462"
  ["GATEWAY_INTERFACE"]=>
  string(7) "CGI/1.1"
  ["SERVER_PROTOCOL"]=>
  string(8) "HTTP/1.1"
  ["REQUEST_METHOD"]=>
  string(3) "GET"
  ["QUERY_STRING"]=>
  string(0) ""
  ["REQUEST_URI"]=>
  string(1) "/"
  ["SCRIPT_NAME"]=>
  string(10) "/index.php"
  ["PHP_SELF"]=>
  string(10) "/index.php"
  ["REQUEST_TIME_FLOAT"]=>
  float(1597414664.114)
  ["REQUEST_TIME"]=>
  int(1597414664)
}
</pre>
</body>
</html>
$ docker stop myphp02
myphp02
$ docker rm myphp02
myphp02

$ docker run -dit --name myphp02 -p 8080:80 myphpimage
$ docker export -o exported.tar myphp02
$ tar tvf exported.tar | head
-rwxr-xr-x  0 0      0           0  8 14 23:19 .dockerenv
drwxr-xr-x  0 0      0           0  8 14 23:11 bin/
-rwxr-xr-x  0 0      0     1168776  4 18  2019 bin/bash
-rwxr-xr-x  0 0      0       38984  7 11  2019 bin/bunzip2
-rwxr-xr-x  0 0      0           0  7 11  2019 bin/bzcat link to bin/bunzip2
lrwxrwxrwx  0 0      0           0  7 11  2019 bin/bzcmp -> bzdiff
-rwxr-xr-x  0 0      0        2227  7 11  2019 bin/bzdiff
lrwxrwxrwx  0 0      0           0  7 11  2019 bin/bzegrep -> bzgrep
-rwxr-xr-x  0 0      0        4877  6 25  2019 bin/bzexe
lrwxrwxrwx  0 0      0           0  7 11  2019 bin/bzfgrep -> bzgrep

$ docker import exported.tar tmp_httpd
sha256:7ccb2060d8f6e16480bd3091da37f86c0663b66f5046287bd3cd3fb9a224f0f7
$ docker run -dit --name myphp03 -p 8080:80 tmp_httpd
docker: Error response from daemon: No command specified.
See 'docker run --help'.

$ docker login
Authenticating with existing credentials...
Login Succeeded
$ docker logout
Removing login credentials for https://index.docker.io/v1/
```