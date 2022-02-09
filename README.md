### PHP 8.12, NGINX, DEBIAN 

## Maintained by: [Mafio](mf1969@gmail.com) 
Source
# https://github.com/docker-library/php
[the Docker Community](https://github.com/docker-library/php)

This is the Git repo of the [Docker "Official Image"](https://github.com/docker-library/official-images#what-are-official-images) for [`php`](https://hub.docker.com/_/php/) (not to be confused with any official `php` image provided by `php` upstream).  
See [the Docker Hub page](https://hub.docker.com/_/php/) for the full readme on how to use this Docker image and for information regarding contributing and issues.
The [full image description on Docker Hub](https://hub.docker.com/_/php/) is generated/maintained over in [the docker-library/docs repository](https://github.com/docker-library/docs), specifically in [the `php` directory](https://github.com/docker-library/docs/tree/master/php).

**For the application to work, it is necessary to run dockerfile or docker-compose**
**To run on the system, docker and docker-compose must be installed**

---

#### Note: All commands are executed in the directory where Dockerfile is located

#### Linux

1.[install docker ubuntu](https://docs.docker.com/compose/install)
2.[install docker-compose ubuntu](https://docs.docker.com/compose/install)

RUN
  
`docker build -t mafio69/php8:12 . && docker run -p 9898:8080 --name php812 mafio69/php8:12 `

#### He put together

[mafio69](mailto:mf1969@gmail.com?subject=[GitHub]%20Docker%20Repo)

