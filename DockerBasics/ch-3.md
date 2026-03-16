```ShellSession
$ cd ~/ghq/github.com/kotaoue/DockerHandsOn/
$ docker run -dit --name my-apache-app -p 8080:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4
Unable to find image 'httpd:2.4' locally
2.4: Pulling from library/httpd
bf5952930446: Pull complete 
3d3fecf6569b: Pull complete 
b5fc3125d912: Pull complete 
679d69c01e90: Pull complete 
76291586768e: Pull complete 
Digest: sha256:3cbdff4bc16681541885ccf1524a532afa28d2a6578ab7c2d5154a7abc182379
Status: Downloaded newer image for httpd:2.4
6dc63bb2870d2e2f4cab5139ea82f4bf6fa2da7ee42418e73276bff1ab93d295
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
6dc63bb2870d        httpd:2.4           "httpd-foreground"   38 seconds ago      Up 37 seconds       0.0.0.0:8080->80/tcp   my-apache-app
$ docker logs
"docker logs" requires exactly 1 argument.
See 'docker logs --help'.

Usage:  docker logs [OPTIONS] CONTAINER

Fetch the logs of a container
$ curl localhost:8080
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
 <head>
  <title>Index of /</title>
 </head>
 <body>
<h1>Index of /</h1>
<ul><li><a href=".git/"> .git/</a></li>
<li><a href="README.md"> README.md</a></li>
<li><a href="ch-2.md"> ch-2.md</a></li>
<li><a href="ch-3.md"> ch-3.md</a></li>
</ul>
</body></html>
$ vim index.html
$ curl localhost:8080
<html>
<head>
<title>index.html</title>
</head>
<body>
I'm index.html
</body>
</html>
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
6dc63bb2870d        httpd:2.4           "httpd-foreground"   8 minutes ago       Up 8 minutes        0.0.0.0:8080->80/tcp   my-apache-app
$ docker stop my-apache-app
my-apache-app
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS                                NAMES
6dc63bb2870d        httpd:2.4           "httpd-foreground"       9 minutes ago       Exited (0) 39 seconds ago                                        my-apache-app
$ docker start my-apache-app
my-apache-app
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
6dc63bb2870d        httpd:2.4           "httpd-foreground"   10 minutes ago      Up 8 seconds        0.0.0.0:8080->80/tcp   my-apache-app
$ docker stop 6dc63bb2870d
6dc63bb2870d
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
6dc63bb2870d        httpd:2.4           "httpd-foreground"   11 minutes ago      Up 3 seconds        0.0.0.0:8080->80/tcp   my-apache-app
$ docker rm my-apache-app
Error response from daemon: You cannot remove a running container 6dc63bb2870d2e2f4cab5139ea82f4bf6fa2da7ee42418e73276bff1ab93d295. Stop the container before attempting removal or force remove
$ docker stop 6dc63bb2870d
6dc63bb2870d
$ docker rm my-apache-app
my-apache-app
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS                                NAMES
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
httpd               2.4                 a6ea92c35c43        3 days ago          166MB
$ docker image rm httpd:2.4
Untagged: httpd:2.4
Untagged: httpd@sha256:3cbdff4bc16681541885ccf1524a532afa28d2a6578ab7c2d5154a7abc182379
Deleted: sha256:a6ea92c35c43206ac8a508b2be7d6d6b5ecf5f40e7a9042a35669bcbcb2da201
Deleted: sha256:074e0e3314f787dd955937eb5b17694b1f7fc64631f404223a62e2a4a1292fb6
Deleted: sha256:b05020dd1c0b21291751d69304826e21518a0fa056229bb5c5646a2f80aa2ce5
Deleted: sha256:0724735f53919994876490bd1e9633792f9533a646f2f5cd6a2c607e4c86909a
Deleted: sha256:378cb5ce0d682b9abc91a9cf70ffc7b0ab650d282d90c60439af8158c944041d
Deleted: sha256:d0f104dc0a1f9c744b65b23b3fd4d4d3236b4656e67f776fe13f8ad8423b955c
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```