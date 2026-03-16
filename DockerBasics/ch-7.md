```ShellSession
$ cd ~/ghq/github.com/kotaoue/DockerHandsOn/

$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a1e8a0a71a42        bridge              bridge              local
d9704bca11b9        host                host                local
42eed01f7563        none                null                local
31584fb54394        wordpressnet        bridge              local

$ docker volume prune
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] y
Deleted Volumes:
mysqlvolume

Total reclaimed space: 413.9MB
$ docker volume ls
DRIVER              VOLUME NAME
$ docker volume create wordpress_db_volume
wordpress_db_volume
$ docker volume ls
DRIVER              VOLUME NAME
local               wordpress_db_volume

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

$ docker run --name wordpress-db -dit --mount type=volume,src=wordpress_db_volume,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=wpdb -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wppass --net wordpressnet mysql:5.7
1894dfe557f2679a04b79991c7fc347aad57af82b8cfd40e5c56ebc21617ad78
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
1894dfe557f2        mysql:5.7           "docker-entrypoint.s…"   5 seconds ago       Up 4 seconds        3306/tcp, 33060/tcp   wordpress-db 

$ docker_search_tags wordpress | wc -l
    1090
$ docker_search_tags wordpress | head
"name": "latest"
"name": "3"
"name": "3.9"
"name": "3.9.1"
"name": "3.9.2"
"name": "4"
"name": "4-apache"
"name": "4-fpm"
"name": "4-fpm-alpine"
"name": "4-php5.6"

$ docker run --name wordpress-app -dit -p 8080:80 -e WORDPRESS_DB_HOST=wordpress-db -e WORDPRESS_DB_NAME=wpdb -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wppass --net wordpressnet wordpress
Unable to find image 'wordpress:latest' locally
latest: Pulling from library/wordpress
bf5952930446: Already exists 
a409b57eb464: Pull complete 
3192e6c84ad0: Pull complete 
43553740162b: Pull complete 
d8b8bba42dea: Pull complete 
eb10907c0110: Pull complete 
10568906f34e: Pull complete 
03fe17709781: Pull complete 
98171b7166c8: Pull complete 
3978c2fb05b8: Pull complete 
71bf21524fa8: Pull complete 
24fe81782f1c: Pull complete 
7a2dfd067aa5: Pull complete 
a04586f4f8fe: Pull complete 
b8059b10e448: Pull complete 
e5b4db4a14b4: Pull complete 
48018c17c4e9: Pull complete 
d09f106f9e16: Pull complete 
289a459a6137: Pull complete 
c4e8f9c90fda: Pull complete 
Digest: sha256:6da8f886b20632dd05eeb22462f850a38e30600cedd894d2c6b1eb1a58e9763c
Status: Downloaded newer image for wordpress:latest
a9deb5008d2cd79b30ebecbd78c46447cafab98b70d18981e0b4f21e063024d4
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
a9deb5008d2c        wordpress           "docker-entrypoint.s…"   6 seconds ago       Up 5 seconds        0.0.0.0:8080->80/tcp   wordpress-app
1894dfe557f2        mysql:5.7           "docker-entrypoint.s…"   3 minutes ago       Up 3 minutes        3306/tcp, 33060/tcp    wordpress-db

$ curl http://localhost:8080
$ curl -s -o /dev/null -w %{http_code} http://localhost:8080/wp-admin/install.php
200$ 

$ docker logs wordpress-app
WordPress not found in /var/www/html - copying now...
Complete! WordPress has been successfully copied to /var/www/html
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.21.0.3. Set the 'ServerName' directive globally to suppress this message
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.21.0.3. Set the 'ServerName' directive globally to suppress this message
[Thu Aug 13 21:51:26.891052 2020] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.38 (Debian) PHP/7.4.9 configured -- resuming normal operations
[Thu Aug 13 21:51:26.891132 2020] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
172.21.0.1 - - [13/Aug/2020:21:52:00 +0000] "GET / HTTP/1.1" 302 404 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:00 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 4475 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-includes/css/dashicons.min.css?ver=5.5 HTTP/1.1" 200 36060 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-includes/css/buttons.min.css?ver=5.5 HTTP/1.1" 200 1788 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/css/l10n.min.css?ver=5.5 HTTP/1.1" 200 1022 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/css/forms.min.css?ver=5.5 HTTP/1.1" 200 6351 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/js/language-chooser.min.js?ver=5.5 HTTP/1.1" 200 618 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/css/install.min.css?ver=5.5 HTTP/1.1" 200 2125 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-includes/js/jquery/jquery.js?ver=1.12.4-wp HTTP/1.1" 200 34130 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/images/wordpress-logo.svg?ver=20131107 HTTP/1.1" 200 1810 "http://localhost:8080/wp-admin/css/install.min.css?ver=5.5" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/images/spinner-2x.gif HTTP/1.1" 200 7822 "http://localhost:8080/wp-admin/css/install.min.css?ver=5.5" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /favicon.ico HTTP/1.1" 302 403 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
172.21.0.1 - - [13/Aug/2020:21:52:01 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 4475 "http://localhost:8080/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36"
127.0.0.1 - - [13/Aug/2020:21:52:08 +0000] "OPTIONS * HTTP/1.0" 200 126 "-" "Apache/2.4.38 (Debian) PHP/7.4.9 (internal dummy connection)"
127.0.0.1 - - [13/Aug/2020:21:52:09 +0000] "OPTIONS * HTTP/1.0" 200 126 "-" "Apache/2.4.38 (Debian) PHP/7.4.9 (internal dummy connection)"
172.21.0.1 - - [13/Aug/2020:21:52:12 +0000] "GET / HTTP/1.1" 302 348 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:52:30 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 12764 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:53:20 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 12764 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:53:28 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 12764 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:53:39 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 12764 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:53:56 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 12764 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:54:03 +0000] "GET / HTTP/1.1" 302 348 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:54:05 +0000] "GET / HTTP/1.1" 302 348 "-" "curl/7.64.1"
172.21.0.1 - - [13/Aug/2020:21:54:08 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 12764 "-" "curl/7.64.1"

$ docker stop wordpress-db wordpress-app
wordpress-db
wordpress-app
$ docker rm wordpress-db wordpress-app
wordpress-db
wordpress-app
$ docker network rm wordpressnet
wordpressnet
$ docker volume rm wordpress_db_volume
wordpress_db_volume

$ docker-compose --version
docker-compose version 1.26.2, build eefe0d31
$ mkdir wordpress
$ cd wordpress/
$ vim docker-compose.yml

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
c7a00aa0b76f        wordpress           "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes        0.0.0.0:8080->80/tcp   wordpress_wordpress-app_1
c2b0031794c5        mysql:5.7           "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes        3306/tcp, 33060/tcp    wordpress_wordpress-db_1
$ docker network ls
NETWORK ID          NAME                     DRIVER              SCOPE
a1e8a0a71a42        bridge                   bridge              local
d9704bca11b9        host                     host                local
42eed01f7563        none                     null                local
9c3c02484b10        wordpress_wordpressnet   bridge              local
$ docker volume ls
DRIVER              VOLUME NAME
local               wordpress_wordpress_db_volume

$ docker-compose down
Stopping wordpress_wordpress-app_1 ... done
Stopping wordpress_wordpress-db_1  ... done
Removing wordpress_wordpress-app_1 ... done
Removing wordpress_wordpress-db_1  ... done
Removing network wordpress_wordpressnet
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a1e8a0a71a42        bridge              bridge              local
d9704bca11b9        host                host                local
42eed01f7563        none                null                local
$ docker volume ls
DRIVER              VOLUME NAME
local               wordpress_wordpress_db_volume

$ docker-compose up -d
ERROR: The Compose file './docker-compose.yml' is invalid because:
services.wordpress-db.volumes contains an invalid type, it should be a string
services.wordpress-db.volumes contains an invalid type, it should be a string
services.wordpress-db.volumes contains an invalid type, it should be a string

$ docker-compose up -d
ERROR: The Compose file './docker-compose.yml' is invalid because:
services.wordpress-db.volumes contains an invalid type, it should be a string
$ docker-compose up -d
ERROR: The Compose file './docker-compose.yml' is invalid because:
services.wordpress-db.volumes contains an invalid type, it should be an array

$ docker-compose up -d
Creating network "wordpress_default" with the default driver
Creating wordpress_wordpress-db_1 ... done
Creating wordpress_wordpress-app_1 ... done
$ docker-compose exec wordpress-app /bin/bash
root@74ecb474c8e2:/var/www/html# ls
index.php    readme.html      wp-admin		  wp-comments-post.php	wp-content   wp-includes	wp-load.php   wp-mail.php      wp-signup.php	 xmlrpc.php
license.txt  wp-activate.php  wp-blog-header.php  wp-config-sample.php	wp-cron.php  wp-links-opml.php	wp-login.php  wp-settings.php  wp-trackback.php
root@74ecb474c8e2:/var/www/html# exit
exit

$ docker-compose stop wordpress-db
Stopping wordpress_wordpress-db_1 ... done
$ docker-compose ps
          Name                         Command               State           Ports        
------------------------------------------------------------------------------------------
wordpress_wordpress-app_1   docker-entrypoint.sh apach ...   Up       0.0.0.0:8080->80/tcp
wordpress_wordpress-db_1    docker-entrypoint.sh mysqld      Exit 0                       
$ docker-compose start wordpress-db
Starting wordpress-db ... done
$ docker-compose ps
          Name                         Command               State          Ports        
-----------------------------------------------------------------------------------------
wordpress_wordpress-app_1   docker-entrypoint.sh apach ...   Up      0.0.0.0:8080->80/tcp
wordpress_wordpress-db_1    docker-entrypoint.sh mysqld      Up      3306/tcp, 33060/tcp 
$ docker-compose down
Stopping wordpress_wordpress-app_1 ... done
Stopping wordpress_wordpress-db_1  ... done
Removing wordpress_wordpress-app_1 ... done
Removing wordpress_wordpress-db_1  ... done
Removing network wordpress_default
```