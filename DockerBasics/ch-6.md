```ShellSession
$ cd ~/ghq/github.com/kotaoue/DockerHandsOn/

$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a1e8a0a71a42        bridge              bridge              local
d9704bca11b9        host                host                local
42eed01f7563        none                null                local

$ docker run -dit --name web01 -p 8080:80 httpd:2.4
0965915c2c9f3190eb68a6952bc7a8f287005fb250b2efb4e219cefb7a0bdf7f
$ docker run -dit --name web02 -p 8081:80 httpd:2.4
48ad01e21077df17f798e9f5d4cd9ba9ed26c5e8d7099f0fd2bf6b0eb7d9f9ed
$ docker exec -it web01 /bin/bash
root@0965915c2c9f:/usr/local/apache2# ifconfig
bash: ifconfig: command not found
root@0965915c2c9f:/usr/local/apache2# exit
exit

$ docker container inspect --format="{{.NetworkSettings.IPAddress}}" web01
172.17.0.2
$ docker container inspect --format="{{.NetworkSettings}}" web01
{{ 00919c1d70b3ad2903aee949561f2203072197f1ab32752cc686a40fcf8c4e65 false  0 map[80/tcp:[{0.0.0.0 8080}]] /var/run/docker/netns/00919c1d70b3 [] []} {0a5962d24143e5b4e069b4e61fe7e1a2fa96b36ddb003180ee76fd7eae796557 172.17.0.1  0 172.17.0.2 16  02:42:ac:11:00:02} map[bridge:0xc0005a0000]}

$ docker container inspect --format='{{range $p, $conf :=.NetworkSettings.Ports}} {{$p}} -. {{(index $conf 0).HostPort}}{{end}}' web01 80/tcp -> 8080
Error: No such container: 80/tcp
Error: No such container: -
$ docker container inspect --format='{{range $p, $conf :=.NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}}{{end}}' web01 80/tcp -> 8080
Error: No such container: 80/tcp
Error: No such container: -
$ docker inspect --format='{{range $p, $conf :=.NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}}{{end}}' web01 80/tcp -> 8080
Error: No such object: 80/tcp
Error: No such object: -
$ docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' web01
 80/tcp -> 8080

$ docker container inspect --format="{{.NetworkSettings.IPAddress}}" web01
172.17.0.2
$ docker container inspect --format="{{.NetworkSettings.IPAddress}}" web02
172.17.0.3

$ docker network inspect --format='{{range $host, $conf := .Containers}}{{$conf.Name}}->{{$conf.IPv4Address}}{{"\n"}}{{end}}' bridge
web01->172.17.0.2/16
web02->172.17.0.3/16

$ docker network inspect --format='{{range $host, $conf := .Containers}}{{$conf.Name}}->{{$conf.IPv4Address}}{{","}}{{end}}' bridge
web01->172.17.0.2/16,web02->172.17.0.3/16,
$ docker network inspect --format='{{range $host, $conf := .Containers}}{{$conf.Name}}->{{$conf.IPv4Address}}{{", "}}{{end}}' bridge
web01->172.17.0.2/16, web02->172.17.0.3/16, 

$ docker run --rm -it ubuntu /bin/bash
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
3ff22d22a855: Pull complete 
e7cb79d19722: Pull complete 
323d0d660b6a: Pull complete 
b7f616834fd0: Pull complete 
Digest: sha256:5d1d5407f353843ecf8b16524bc5565aa332e9e6a1297c73a92d3e754b8a636d
Status: Downloaded newer image for ubuntu:latest

root@a0bc22e7e4ef:/# apt update
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [107 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal InRelease [265 kB]
Get:3 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [62.9 kB]
Get:4 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [200 kB]
Get:5 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [39.1 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates InRelease [111 kB]      
Get:7 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [1078 B]
Get:8 http://archive.ubuntu.com/ubuntu focal-backports InRelease [98.3 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal/universe amd64 Packages [11.3 MB]
Get:10 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 Packages [177 kB]                                                                                                                           
Get:11 http://archive.ubuntu.com/ubuntu focal/main amd64 Packages [1275 kB]                                                                                                                                
Get:12 http://archive.ubuntu.com/ubuntu focal/restricted amd64 Packages [33.4 kB]                                                                                                                          
Get:13 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [17.3 kB]                                                                                                                  
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [417 kB]                                                                                                                         
Get:15 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [193 kB]                                                                                                                     
Get:16 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [39.1 kB]                                                                                                                  
Get:17 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [3216 B]                                                                                                                   
Fetched 14.4 MB in 16s (909 kB/s)                                                                                                                                                                          
Reading package lists... Done
Building dependency tree       
Reading state information... Done
4 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@a0bc22e7e4ef:/# apt -y upgrade
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
The following packages will be upgraded:
  base-files libseccomp2 libsystemd0 libudev1
4 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Need to get 453 kB of archives.
After this operation, 3072 B of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 base-files amd64 11ubuntu5.1 [60.1 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libsystemd0 amd64 245.4-4ubuntu3.2 [271 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libudev1 amd64 245.4-4ubuntu3.2 [78.9 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libseccomp2 amd64 2.4.3-1ubuntu3.20.04.3 [42.4 kB]
Fetched 453 kB in 2s (214 kB/s)      
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 4122 files and directories currently installed.)
Preparing to unpack .../base-files_11ubuntu5.1_amd64.deb ...
Unpacking base-files (11ubuntu5.1) over (11ubuntu5) ...
Setting up base-files (11ubuntu5.1) ...
Installing new version of config file /etc/issue ...
Installing new version of config file /etc/issue.net ...
Installing new version of config file /etc/lsb-release ...
(Reading database ... 4122 files and directories currently installed.)
Preparing to unpack .../libsystemd0_245.4-4ubuntu3.2_amd64.deb ...
Unpacking libsystemd0:amd64 (245.4-4ubuntu3.2) over (245.4-4ubuntu3.1) ...
Setting up libsystemd0:amd64 (245.4-4ubuntu3.2) ...
(Reading database ... 4122 files and directories currently installed.)
Preparing to unpack .../libudev1_245.4-4ubuntu3.2_amd64.deb ...
Unpacking libudev1:amd64 (245.4-4ubuntu3.2) over (245.4-4ubuntu3.1) ...
Setting up libudev1:amd64 (245.4-4ubuntu3.2) ...
(Reading database ... 4122 files and directories currently installed.)
Preparing to unpack .../libseccomp2_2.4.3-1ubuntu3.20.04.3_amd64.deb ...
Unpacking libseccomp2:amd64 (2.4.3-1ubuntu3.20.04.3) over (2.4.3-1ubuntu3.20.04.2) ...
Setting up libseccomp2:amd64 (2.4.3-1ubuntu3.20.04.3) ...
Processing triggers for libc-bin (2.31-0ubuntu9) ...
root@a0bc22e7e4ef:/# apt install -y iproute2 iputils-ping curl
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  ca-certificates krb5-locales libasn1-8-heimdal libatm1 libbrotli1 libbsd0 libcap2 libcap2-bin libcurl4 libelf1 libgssapi-krb5-2 libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal
  libheimntlm0-heimdal libhx509-5-heimdal libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 libldap-common libmnl0 libnghttp2-14 libpam-cap libpsl5 libroken18-heimdal
  librtmp1 libsasl2-2 libsasl2-modules libsasl2-modules-db libsqlite3-0 libssh-4 libssl1.1 libwind0-heimdal libxtables12 openssl publicsuffix
Suggested packages:
  iproute2-doc krb5-doc krb5-user libsasl2-modules-gssapi-mit | libsasl2-modules-gssapi-heimdal libsasl2-modules-ldap libsasl2-modules-otp libsasl2-modules-sql
The following NEW packages will be installed:
  ca-certificates curl iproute2 iputils-ping krb5-locales libasn1-8-heimdal libatm1 libbrotli1 libbsd0 libcap2 libcap2-bin libcurl4 libelf1 libgssapi-krb5-2 libgssapi3-heimdal libhcrypto4-heimdal
  libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 libldap-common libmnl0 libnghttp2-14 libpam-cap
  libpsl5 libroken18-heimdal librtmp1 libsasl2-2 libsasl2-modules libsasl2-modules-db libsqlite3-0 libssh-4 libssl1.1 libwind0-heimdal libxtables12 openssl publicsuffix
0 upgraded, 42 newly installed, 0 to remove and 0 not upgraded.
Need to get 6546 kB of archives.
After this operation, 20.5 MB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libssl1.1 amd64 1.1.1f-1ubuntu2 [1318 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 openssl amd64 1.1.1f-1ubuntu2 [621 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 ca-certificates all 20190110ubuntu1.1 [145 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 libbsd0 amd64 0.10.0-1 [45.4 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libcap2 amd64 1:2.32-1 [15.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal/main amd64 libelf1 amd64 0.176-1.1build1 [44.0 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal/main amd64 libmnl0 amd64 1.0.4-2 [12.3 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal/main amd64 libxtables12 amd64 1.8.4-3ubuntu2 [28.4 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal/main amd64 libcap2-bin amd64 1:2.32-1 [26.2 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal/main amd64 iproute2 amd64 5.5.0-1ubuntu1 [858 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal/main amd64 iputils-ping amd64 3:20190709-3 [40.1 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal/main amd64 libatm1 amd64 1:2.5.1-4 [21.8 kB]
Get:13 http://archive.ubuntu.com/ubuntu focal/main amd64 libpam-cap amd64 1:2.32-1 [8352 B]
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libsqlite3-0 amd64 3.31.1-4ubuntu0.2 [549 kB]
Get:15 http://archive.ubuntu.com/ubuntu focal/main amd64 krb5-locales all 1.17-6ubuntu4 [11.4 kB]
Get:16 http://archive.ubuntu.com/ubuntu focal/main amd64 libkrb5support0 amd64 1.17-6ubuntu4 [30.9 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal/main amd64 libk5crypto3 amd64 1.17-6ubuntu4 [80.2 kB]
Get:18 http://archive.ubuntu.com/ubuntu focal/main amd64 libkeyutils1 amd64 1.6-6ubuntu1 [10.2 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal/main amd64 libkrb5-3 amd64 1.17-6ubuntu4 [330 kB]
Get:20 http://archive.ubuntu.com/ubuntu focal/main amd64 libgssapi-krb5-2 amd64 1.17-6ubuntu4 [121 kB]
Get:21 http://archive.ubuntu.com/ubuntu focal/main amd64 libpsl5 amd64 0.21.0-1ubuntu1 [51.5 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal/main amd64 publicsuffix all 20200303.0012-1 [111 kB]
Get:23 http://archive.ubuntu.com/ubuntu focal/main amd64 libbrotli1 amd64 1.0.7-6build1 [270 kB]
Get:24 http://archive.ubuntu.com/ubuntu focal/main amd64 libroken18-heimdal amd64 7.7.0+dfsg-1ubuntu1 [41.8 kB]
Get:25 http://archive.ubuntu.com/ubuntu focal/main amd64 libasn1-8-heimdal amd64 7.7.0+dfsg-1ubuntu1 [181 kB]
Get:26 http://archive.ubuntu.com/ubuntu focal/main amd64 libheimbase1-heimdal amd64 7.7.0+dfsg-1ubuntu1 [29.7 kB]
Get:27 http://archive.ubuntu.com/ubuntu focal/main amd64 libhcrypto4-heimdal amd64 7.7.0+dfsg-1ubuntu1 [87.9 kB]
Get:28 http://archive.ubuntu.com/ubuntu focal/main amd64 libwind0-heimdal amd64 7.7.0+dfsg-1ubuntu1 [48.0 kB]                                                                                              
Get:29 http://archive.ubuntu.com/ubuntu focal/main amd64 libhx509-5-heimdal amd64 7.7.0+dfsg-1ubuntu1 [107 kB]                                                                                             
Get:30 http://archive.ubuntu.com/ubuntu focal/main amd64 libkrb5-26-heimdal amd64 7.7.0+dfsg-1ubuntu1 [208 kB]                                                                                             
Get:31 http://archive.ubuntu.com/ubuntu focal/main amd64 libheimntlm0-heimdal amd64 7.7.0+dfsg-1ubuntu1 [15.1 kB]                                                                                          
Get:32 http://archive.ubuntu.com/ubuntu focal/main amd64 libgssapi3-heimdal amd64 7.7.0+dfsg-1ubuntu1 [96.1 kB]                                                                                            
Get:33 http://archive.ubuntu.com/ubuntu focal/main amd64 libsasl2-modules-db amd64 2.1.27+dfsg-2 [14.9 kB]                                                                                                 
Get:34 http://archive.ubuntu.com/ubuntu focal/main amd64 libsasl2-2 amd64 2.1.27+dfsg-2 [49.3 kB]                                                                                                          
Get:35 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libldap-common all 2.4.49+dfsg-2ubuntu1.3 [17.0 kB]                                                                                       
Get:36 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libldap-2.4-2 amd64 2.4.49+dfsg-2ubuntu1.3 [155 kB]                                                                                       
Get:37 http://archive.ubuntu.com/ubuntu focal/main amd64 libnghttp2-14 amd64 1.40.0-1build1 [78.7 kB]                                                                                                      
Get:38 http://archive.ubuntu.com/ubuntu focal/main amd64 librtmp1 amd64 2.4+20151223.gitfa8646d.1-2build1 [54.9 kB]                                                                                        
Get:39 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libssh-4 amd64 0.9.3-2ubuntu2.1 [170 kB]                                                                                                  
Get:40 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libcurl4 amd64 7.68.0-1ubuntu2.1 [233 kB]                                                                                                 
Get:41 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 curl amd64 7.68.0-1ubuntu2.1 [162 kB]                                                                                                     
Get:42 http://archive.ubuntu.com/ubuntu focal/main amd64 libsasl2-modules amd64 2.1.27+dfsg-2 [49.1 kB]                                                                                                    
Fetched 6546 kB in 7s (937 kB/s)                                                                                                                                                                           
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libssl1.1:amd64.
(Reading database ... 4122 files and directories currently installed.)
Preparing to unpack .../00-libssl1.1_1.1.1f-1ubuntu2_amd64.deb ...
Unpacking libssl1.1:amd64 (1.1.1f-1ubuntu2) ...
Selecting previously unselected package openssl.
Preparing to unpack .../01-openssl_1.1.1f-1ubuntu2_amd64.deb ...
Unpacking openssl (1.1.1f-1ubuntu2) ...
Selecting previously unselected package ca-certificates.
Preparing to unpack .../02-ca-certificates_20190110ubuntu1.1_all.deb ...
Unpacking ca-certificates (20190110ubuntu1.1) ...
Selecting previously unselected package libbsd0:amd64.
Preparing to unpack .../03-libbsd0_0.10.0-1_amd64.deb ...
Unpacking libbsd0:amd64 (0.10.0-1) ...
Selecting previously unselected package libcap2:amd64.
Preparing to unpack .../04-libcap2_1%3a2.32-1_amd64.deb ...
Unpacking libcap2:amd64 (1:2.32-1) ...
Selecting previously unselected package libelf1:amd64.
Preparing to unpack .../05-libelf1_0.176-1.1build1_amd64.deb ...
Unpacking libelf1:amd64 (0.176-1.1build1) ...
Selecting previously unselected package libmnl0:amd64.
Preparing to unpack .../06-libmnl0_1.0.4-2_amd64.deb ...
Unpacking libmnl0:amd64 (1.0.4-2) ...
Selecting previously unselected package libxtables12:amd64.
Preparing to unpack .../07-libxtables12_1.8.4-3ubuntu2_amd64.deb ...
Unpacking libxtables12:amd64 (1.8.4-3ubuntu2) ...
Selecting previously unselected package libcap2-bin.
Preparing to unpack .../08-libcap2-bin_1%3a2.32-1_amd64.deb ...
Unpacking libcap2-bin (1:2.32-1) ...
Selecting previously unselected package iproute2.
Preparing to unpack .../09-iproute2_5.5.0-1ubuntu1_amd64.deb ...
Unpacking iproute2 (5.5.0-1ubuntu1) ...
Selecting previously unselected package iputils-ping.
Preparing to unpack .../10-iputils-ping_3%3a20190709-3_amd64.deb ...
Unpacking iputils-ping (3:20190709-3) ...
Selecting previously unselected package libatm1:amd64.
Preparing to unpack .../11-libatm1_1%3a2.5.1-4_amd64.deb ...
Unpacking libatm1:amd64 (1:2.5.1-4) ...
Selecting previously unselected package libpam-cap:amd64.
Preparing to unpack .../12-libpam-cap_1%3a2.32-1_amd64.deb ...
Unpacking libpam-cap:amd64 (1:2.32-1) ...
Selecting previously unselected package libsqlite3-0:amd64.
Preparing to unpack .../13-libsqlite3-0_3.31.1-4ubuntu0.2_amd64.deb ...
Unpacking libsqlite3-0:amd64 (3.31.1-4ubuntu0.2) ...
Selecting previously unselected package krb5-locales.
Preparing to unpack .../14-krb5-locales_1.17-6ubuntu4_all.deb ...
Unpacking krb5-locales (1.17-6ubuntu4) ...
Selecting previously unselected package libkrb5support0:amd64.
Preparing to unpack .../15-libkrb5support0_1.17-6ubuntu4_amd64.deb ...
Unpacking libkrb5support0:amd64 (1.17-6ubuntu4) ...
Selecting previously unselected package libk5crypto3:amd64.
Preparing to unpack .../16-libk5crypto3_1.17-6ubuntu4_amd64.deb ...
Unpacking libk5crypto3:amd64 (1.17-6ubuntu4) ...
Selecting previously unselected package libkeyutils1:amd64.
Preparing to unpack .../17-libkeyutils1_1.6-6ubuntu1_amd64.deb ...
Unpacking libkeyutils1:amd64 (1.6-6ubuntu1) ...
Selecting previously unselected package libkrb5-3:amd64.
Preparing to unpack .../18-libkrb5-3_1.17-6ubuntu4_amd64.deb ...
Unpacking libkrb5-3:amd64 (1.17-6ubuntu4) ...
Selecting previously unselected package libgssapi-krb5-2:amd64.
Preparing to unpack .../19-libgssapi-krb5-2_1.17-6ubuntu4_amd64.deb ...
Unpacking libgssapi-krb5-2:amd64 (1.17-6ubuntu4) ...
Selecting previously unselected package libpsl5:amd64.
Preparing to unpack .../20-libpsl5_0.21.0-1ubuntu1_amd64.deb ...
Unpacking libpsl5:amd64 (0.21.0-1ubuntu1) ...
Selecting previously unselected package publicsuffix.
Preparing to unpack .../21-publicsuffix_20200303.0012-1_all.deb ...
Unpacking publicsuffix (20200303.0012-1) ...
Selecting previously unselected package libbrotli1:amd64.
Preparing to unpack .../22-libbrotli1_1.0.7-6build1_amd64.deb ...
Unpacking libbrotli1:amd64 (1.0.7-6build1) ...
Selecting previously unselected package libroken18-heimdal:amd64.
Preparing to unpack .../23-libroken18-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libroken18-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libasn1-8-heimdal:amd64.
Preparing to unpack .../24-libasn1-8-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libasn1-8-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libheimbase1-heimdal:amd64.
Preparing to unpack .../25-libheimbase1-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libheimbase1-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libhcrypto4-heimdal:amd64.
Preparing to unpack .../26-libhcrypto4-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libhcrypto4-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libwind0-heimdal:amd64.
Preparing to unpack .../27-libwind0-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libwind0-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libhx509-5-heimdal:amd64.
Preparing to unpack .../28-libhx509-5-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libhx509-5-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libkrb5-26-heimdal:amd64.
Preparing to unpack .../29-libkrb5-26-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libkrb5-26-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libheimntlm0-heimdal:amd64.
Preparing to unpack .../30-libheimntlm0-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libheimntlm0-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libgssapi3-heimdal:amd64.
Preparing to unpack .../31-libgssapi3-heimdal_7.7.0+dfsg-1ubuntu1_amd64.deb ...
Unpacking libgssapi3-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Selecting previously unselected package libsasl2-modules-db:amd64.
Preparing to unpack .../32-libsasl2-modules-db_2.1.27+dfsg-2_amd64.deb ...
Unpacking libsasl2-modules-db:amd64 (2.1.27+dfsg-2) ...
Selecting previously unselected package libsasl2-2:amd64.
Preparing to unpack .../33-libsasl2-2_2.1.27+dfsg-2_amd64.deb ...
Unpacking libsasl2-2:amd64 (2.1.27+dfsg-2) ...
Selecting previously unselected package libldap-common.
Preparing to unpack .../34-libldap-common_2.4.49+dfsg-2ubuntu1.3_all.deb ...
Unpacking libldap-common (2.4.49+dfsg-2ubuntu1.3) ...
Selecting previously unselected package libldap-2.4-2:amd64.
Preparing to unpack .../35-libldap-2.4-2_2.4.49+dfsg-2ubuntu1.3_amd64.deb ...
Unpacking libldap-2.4-2:amd64 (2.4.49+dfsg-2ubuntu1.3) ...
Selecting previously unselected package libnghttp2-14:amd64.
Preparing to unpack .../36-libnghttp2-14_1.40.0-1build1_amd64.deb ...
Unpacking libnghttp2-14:amd64 (1.40.0-1build1) ...
Selecting previously unselected package librtmp1:amd64.
Preparing to unpack .../37-librtmp1_2.4+20151223.gitfa8646d.1-2build1_amd64.deb ...
Unpacking librtmp1:amd64 (2.4+20151223.gitfa8646d.1-2build1) ...
Selecting previously unselected package libssh-4:amd64.
Preparing to unpack .../38-libssh-4_0.9.3-2ubuntu2.1_amd64.deb ...
Unpacking libssh-4:amd64 (0.9.3-2ubuntu2.1) ...
Selecting previously unselected package libcurl4:amd64.
Preparing to unpack .../39-libcurl4_7.68.0-1ubuntu2.1_amd64.deb ...
Unpacking libcurl4:amd64 (7.68.0-1ubuntu2.1) ...
Selecting previously unselected package curl.
Preparing to unpack .../40-curl_7.68.0-1ubuntu2.1_amd64.deb ...
Unpacking curl (7.68.0-1ubuntu2.1) ...
Selecting previously unselected package libsasl2-modules:amd64.
Preparing to unpack .../41-libsasl2-modules_2.1.27+dfsg-2_amd64.deb ...
Unpacking libsasl2-modules:amd64 (2.1.27+dfsg-2) ...
Setting up libkeyutils1:amd64 (1.6-6ubuntu1) ...
Setting up libpsl5:amd64 (0.21.0-1ubuntu1) ...
Setting up libssl1.1:amd64 (1.1.1f-1ubuntu2) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.30.0 /usr/local/share/perl/5.30.0 /usr/lib/x86_64-linux-gnu/perl5/5.30 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.30 /usr/share/perl/5.30 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up libbrotli1:amd64 (1.0.7-6build1) ...
Setting up libsqlite3-0:amd64 (3.31.1-4ubuntu0.2) ...
Setting up libsasl2-modules:amd64 (2.1.27+dfsg-2) ...
Setting up libnghttp2-14:amd64 (1.40.0-1build1) ...
Setting up krb5-locales (1.17-6ubuntu4) ...
Setting up libatm1:amd64 (1:2.5.1-4) ...
Setting up libldap-common (2.4.49+dfsg-2ubuntu1.3) ...
Setting up libcap2:amd64 (1:2.32-1) ...
Setting up libkrb5support0:amd64 (1.17-6ubuntu4) ...
Setting up libsasl2-modules-db:amd64 (2.1.27+dfsg-2) ...
Setting up libcap2-bin (1:2.32-1) ...
Setting up librtmp1:amd64 (2.4+20151223.gitfa8646d.1-2build1) ...
Setting up libmnl0:amd64 (1.0.4-2) ...
Setting up libk5crypto3:amd64 (1.17-6ubuntu4) ...
Setting up libxtables12:amd64 (1.8.4-3ubuntu2) ...
Setting up libsasl2-2:amd64 (2.1.27+dfsg-2) ...
Setting up libroken18-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libkrb5-3:amd64 (1.17-6ubuntu4) ...
Setting up openssl (1.1.1f-1ubuntu2) ...
Setting up libbsd0:amd64 (0.10.0-1) ...
Setting up libelf1:amd64 (0.176-1.1build1) ...
Setting up libpam-cap:amd64 (1:2.32-1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.30.0 /usr/local/share/perl/5.30.0 /usr/lib/x86_64-linux-gnu/perl5/5.30 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.30 /usr/share/perl/5.30 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up iputils-ping (3:20190709-3) ...
Setting up publicsuffix (20200303.0012-1) ...
Setting up libheimbase1-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up iproute2 (5.5.0-1ubuntu1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.30.0 /usr/local/share/perl/5.30.0 /usr/lib/x86_64-linux-gnu/perl5/5.30 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.30 /usr/share/perl/5.30 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up libasn1-8-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libhcrypto4-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up ca-certificates (20190110ubuntu1.1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.30.0 /usr/local/share/perl/5.30.0 /usr/lib/x86_64-linux-gnu/perl5/5.30 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.30 /usr/share/perl/5.30 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Updating certificates in /etc/ssl/certs...
127 added, 0 removed; done.
Setting up libwind0-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libgssapi-krb5-2:amd64 (1.17-6ubuntu4) ...
Setting up libssh-4:amd64 (0.9.3-2ubuntu2.1) ...
Setting up libhx509-5-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libkrb5-26-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libheimntlm0-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libgssapi3-heimdal:amd64 (7.7.0+dfsg-1ubuntu1) ...
Setting up libldap-2.4-2:amd64 (2.4.49+dfsg-2ubuntu1.3) ...
Setting up libcurl4:amd64 (7.68.0-1ubuntu2.1) ...
Setting up curl (7.68.0-1ubuntu2.1) ...
Processing triggers for libc-bin (2.31-0ubuntu9) ...
Processing triggers for ca-certificates (20190110ubuntu1.1) ...
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.

root@a0bc22e7e4ef:/# ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN group default qlen 1000
    link/tunnel6 :: brd ::
66: eth0@if67: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:04 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.4/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever   

root@a0bc22e7e4ef:/# ping -c 1 172.17.0.2
PING 172.17.0.2 (172.17.0.2) 56(84) bytes of data.
64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.165 ms

--- 172.17.0.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.165/0.165/0.165/0.000 ms
root@a0bc22e7e4ef:/# ping -c 1 172.17.0.3
PING 172.17.0.3 (172.17.0.3) 56(84) bytes of data.
64 bytes from 172.17.0.3: icmp_seq=1 ttl=64 time=0.139 ms

--- 172.17.0.3 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.139/0.139/0.139/0.000 ms

root@015f38ad5fc5:/# curl http://172.17.0.2/
<html><body><h1>It works!</h1></body></html>
root@015f38ad5fc5:/# curl http://172.17.0.3/
<html><body><h1>It works!</h1></body></html>
root@015f38ad5fc5:/# ping -c web01
ping: invalid argument: 'web01'
root@015f38ad5fc5:/# curl http://web01/
curl: (6) Could not resolve host: web01
root@015f38ad5fc5:/# exit
exit

$ docker run --rm -it --link web01:web01 --link web02:web02 ubuntu /bin/bash
root@493714b6dbf1:/# apt update > /dev/null 2>&1
root@493714b6dbf1:/# apt -y upgrade > /dev/null 2>&1
root@493714b6dbf1:/# apt install -y iproute2 iputils-ping curl > /dev/null 2>&1
root@493714b6dbf1:/# ping -c 1 web01 
PING web01 (172.17.0.2) 56(84) bytes of data.
64 bytes from web01 (172.17.0.2): icmp_seq=1 ttl=64 time=0.123 ms

--- web01 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.123/0.123/0.123/0.000 ms
root@493714b6dbf1:/# ping -c 1 web02
PING web02 (172.17.0.3) 56(84) bytes of data.
64 bytes from web02 (172.17.0.3): icmp_seq=1 ttl=64 time=0.098 ms

--- web02 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.098/0.098/0.098/0.000 ms
root@493714b6dbf1:/# curl http://web01/
<html><body><h1>It works!</h1></body></html>
root@493714b6dbf1:/# curl http://web02/
<html><body><h1>It works!</h1></body></html>
root@493714b6dbf1:/# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	web01 0965915c2c9f
172.17.0.3	web02 48ad01e21077
172.17.0.4	620cf4bb7e01
root@493714b6dbf1:/# exit
exit

$ docker network create mydockernet
2d1b7a6a29f2e711e54da495f49fe0771b77bb91d302176bfa70d993e3f3f877
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a1e8a0a71a42        bridge              bridge              local
d9704bca11b9        host                host                local
2d1b7a6a29f2        mydockernet         bridge              local
42eed01f7563        none                null                local
$ docker network inspect mydockernet
[
    {
        "Name": "mydockernet",
        "Id": "2d1b7a6a29f2e711e54da495f49fe0771b77bb91d302176bfa70d993e3f3f877",
        "Created": "2020-08-13T07:23:57.4723128Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]

$ docker network create examplenet --subnet 10.0.0.0/16 --gateway 10.0.0.1
34db2961eab1dc39b65f80d06c44e607ac5d59f91ec90918b8f5008785b5f9e6
$ docker network inspect examplenet
[
    {
        "Name": "examplenet",
        "Id": "34db2961eab1dc39b65f80d06c44e607ac5d59f91ec90918b8f5008785b5f9e6",
        "Created": "2020-08-13T07:25:43.4603551Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "10.0.0.0/16",
                    "Gateway": "10.0.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]
$ docker network rm examplenet
examplenet

$ docker stop web01 web02
web01
web02
$ docker rm web01 web02
web01
web02

$ docker run -dit --name web01 -p 8080:80 --net mydockernet httpd:2.4
7ed554568c73b1b1f3245e16605e095c2fe32b020ba99a1bf266273027246f2a
$ docker run -dit --name web02 -p 8081:80 --net mydockernet httpd:2.4
6ab96d95700d39e699b369ded442976558230ec5b5dbe110279d760963ad8475
$ docker network inspect mydockernet
[
    {
        "Name": "mydockernet",
        "Id": "2d1b7a6a29f2e711e54da495f49fe0771b77bb91d302176bfa70d993e3f3f877",
        "Created": "2020-08-13T07:23:57.4723128Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "6ab96d95700d39e699b369ded442976558230ec5b5dbe110279d760963ad8475": {
                "Name": "web02",
                "EndpointID": "7413100d4a5a5675535409bb36276706252d59c09e73869d548b869fcbb397a2",
                "MacAddress": "02:42:ac:14:00:03",
                "IPv4Address": "172.20.0.3/16",
                "IPv6Address": ""
            },
            "7ed554568c73b1b1f3245e16605e095c2fe32b020ba99a1bf266273027246f2a": {
                "Name": "web01",
                "EndpointID": "12488984180eda1ac326b5a17f023971878594fb28e8acd1a247b1c65128f27e",
                "MacAddress": "02:42:ac:14:00:02",
                "IPv4Address": "172.20.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

$ docker network disconnect mydockernet web01 
$ docker network inspect mydockernet
[
    {
        "Name": "mydockernet",
        "Id": "2d1b7a6a29f2e711e54da495f49fe0771b77bb91d302176bfa70d993e3f3f877",
        "Created": "2020-08-13T07:23:57.4723128Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "6ab96d95700d39e699b369ded442976558230ec5b5dbe110279d760963ad8475": {
                "Name": "web02",
                "EndpointID": "7413100d4a5a5675535409bb36276706252d59c09e73869d548b869fcbb397a2",
                "MacAddress": "02:42:ac:14:00:03",
                "IPv4Address": "172.20.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
$ docker network connect mydockernet web01
$ docker network inspect mydockernet
[
    {
        "Name": "mydockernet",
        "Id": "2d1b7a6a29f2e711e54da495f49fe0771b77bb91d302176bfa70d993e3f3f877",
        "Created": "2020-08-13T07:23:57.4723128Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "6ab96d95700d39e699b369ded442976558230ec5b5dbe110279d760963ad8475": {
                "Name": "web02",
                "EndpointID": "7413100d4a5a5675535409bb36276706252d59c09e73869d548b869fcbb397a2",
                "MacAddress": "02:42:ac:14:00:03",
                "IPv4Address": "172.20.0.3/16",
                "IPv6Address": ""
            },
            "7ed554568c73b1b1f3245e16605e095c2fe32b020ba99a1bf266273027246f2a": {
                "Name": "web01",
                "EndpointID": "3f3592fdcbe32960e03f083adb738fda4c2d65d47b544d03ada3661701e8ce57",
                "MacAddress": "02:42:ac:14:00:02",
                "IPv4Address": "172.20.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

$ docker run --rm -it --net mydockernet ubuntu /bin/bash
root@ea3b38ba9fbc:/# apt update > /dev/null 2>&1
root@ea3b38ba9fbc:/# apt -y upgrade > /dev/null 2>&1
root@ea3b38ba9fbc:/# apt install -y iproute2 iputils-ping curl > /dev/null 2>&1

root@ea3b38ba9fbc:/# ping -c 1 web01
PING web01 (172.20.0.2) 56(84) bytes of data.
64 bytes from web01.mydockernet (172.20.0.2): icmp_seq=1 ttl=64 time=0.338 ms

--- web01 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.338/0.338/0.338/0.000 ms
root@ea3b38ba9fbc:/# cat /etc/resolv.conf 
nameserver 127.0.0.11
options ndots:0
root@ea3b38ba9fbc:/# exit
exit

$ docker network rm mydockernet
Error response from daemon: error while removing network: network mydockernet id 2d1b7a6a29f2e711e54da495f49fe0771b77bb91d302176bfa70d993e3f3f877 has active endpoints
$ docker stop web01 web02
web01
web02
$ docker network rm mydockernet
mydockernet
$ docker rm web01 web02
web01
web02
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a1e8a0a71a42        bridge              bridge              local
d9704bca11b9        host                host                local
42eed01f7563        none                null                local
```