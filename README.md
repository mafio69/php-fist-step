# https://github.com/docker-library/php

## Maintained by: [Mafio](mf1969@gmail.com) 
Source
[the Docker Community](https://github.com/docker-library/php)

This is the Git repo of the [Docker "Official Image"](https://github.com/docker-library/official-images#what-are-official-images) for [`php`](https://hub.docker.com/_/php/) (not to be confused with any official `php` image provided by `php` upstream).  
See [the Docker Hub page](https://hub.docker.com/_/php/) for the full readme on how to use this Docker image and for information regarding contributing and issues.
The [full image description on Docker Hub](https://hub.docker.com/_/php/) is generated/maintained over in [the docker-library/docs repository](https://github.com/docker-library/docs), specifically in [the `php` directory](https://github.com/docker-library/docs/tree/master/php).

**For the application to work, it is necessary to run dockerfile or docker-compose**
**To run on the system, docker and docker-compose must be installed**

---

# Note: All commands are executed in the directory where docker-compose.yml is located

#### Linux

1.[install docker ubuntu](https://docs.docker.com/compose/install)
2.[install docker-compose ubuntu](https://docs.docker.com/compose/install)

#### WIN

1.[install docker win 10](https://docs.docker.com/docker-for-windows/install/)

**NOTE `<EXAMPLE>` To be replaced with the appropriate values**
**`exit 0` or `exit status 0` In linux it means `[OK]` any other number is an error**

### Env configuration files to be edited by the developer

`./.env` and `./main/.env.local`
**we do not change `./main/.env`** file !

## RUN APPLICATION

---

### ROAD MAP:

### First run

Build `./.env` the file from `./.env_example`Build `./main/.env.local` the file from `./main/.env.local_example`1.terminal in host `docker-compose up --build`2 terminal in host  run-command bash `docker ps`3 from displayed list get CONTAINER ID where NAMES api-* (example CONTAINER_ID `df6e4586f8ae`)4 run in terminal host `docker exec -it <CONTAINER_ID> bash`

- terminal in container  `cd /main`
- terminal in container next `composer install -o`
- terminal in container end   `exit` out container terminal

5 terminal in host `docker-compose down`
6 terminal in host `docker-compose up --build` . **It works!**
Additionally, the permissions of the directories must be changed:
`./logs`
`./main/var`
example `chmod 777 -R ./main/var`

### Next starts

`docker-compose up --build` or faster `docker-compose up`

### New code

If change devops code use script (Preventive with each new branch) `./container/scripts-sh/restart-docker-compose.sh`

## TESTS RUN

---

Symfony documentation test  
https://symfony.com/doc/current/testing.html  
Command in host (On your computer)  
Listing container `docker ps`  
`docker exec -it <docker id> bash`  
Command in container 'api-cc':  
`cd /main`  
Make test `php bin/console make:test` (choice WebTestCase)  
Run test `php ./vendor/bin/phpunit`

##**NOTE**

---

- In addition, in the directory `./container/scripts-sh` there are scripts for restarting the reset
- in case of port conflicts, database name ... it is possible to change the value in the `./.env`  file in the
  .env_example**_ file
- we do not change `./main/.env` file ! This file is common to all environments and users. Placed in the repository
  according to the Symfony documentation
### Links according to the .env_example file:
NOTE: RUN `docker ps` The list will include the port, e.g. 8070:8080 the first is the host port, e.g. http://localhost:8070   
used in the browser should display a running application  
app: http://localhost:<WEB_PORT>  
database: localhost:<DATABASE_PORT_LOCAL> user: <DATABASE_USER>(test)   
password:<DATABASE_PASSWORD>(1234) database:<DATABASE_NAME>(ccfound)


### Links according to the .env_example file:

NOTE: RUN `docker ps` The list will include the port, e.g. 8070:8080 the first is the host port, e.g. http://localhost:8070
used in the browser should display a running application
app: http://localhost:<WEB_PORT>
database: localhost:<DATABASE_PORT_LOCAL> user: <DATABASE_USER>(test)
password:<DATABASE_PASSWORD>(1234) database:<DATABASE_NAME>(ccfound)

## WARNING

### All discovered passwords are examples, all addresses also apply to the local network, after deploying locally, they should be changed.

#### He put together

[mafio69](mailto:mf1969@gmail.com?subject=[GitHub]%20Docker%20Repo)

