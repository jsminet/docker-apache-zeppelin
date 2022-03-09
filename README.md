# docker-apache-zeppelin
Docker compose file for Apache Zeppelin building

# Usage

Check config setup

```$ docker-compose config```

Launching build

```$ docker-compose up --build zeppelin-distribution```

# Volumes

As an IN -> *maven-repo* contains the downloaded jars from maven repository 

As an OUT -> *distro* contains the Apache Zeppelin compressed and compiled binaries

## Check the volumes

```$ docker volume ls ```

| DRIVER | VOLUME NAME | 
|---|---|
| local  | docker-apache-zeppelin_distro | 
| local  | docker-apache-zeppelin_maven-repo | 

```$ docker volume inspect docker-apache-zeppelin_distro```

    {
        "CreatedAt": "2022-03-09T19:49:12Z",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "docker-apache-zeppelin",
            "com.docker.compose.version": "1.29.2",
            "com.docker.compose.volume": "distro"
        },
        "Mountpoint": "/var/lib/docker/volumes/docker-apache-zeppelin_distro/_data",
        "Name": "docker-apache-zeppelin_distro",
        "Options": null,
        "Scope": "local"
    }

```$ sudo ls /var/lib/docker/volumes/docker-apache-zeppelin_distro/_data```