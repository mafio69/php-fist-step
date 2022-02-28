*Tested on ubuntu 20.04
MICROSERVICE:  
  PHP :   `Warning: Module "zip" is already loaded in Unknown on line 0  
          PHP 8.1.2 (cli) (built: Jan 26 2022 16:40:42) (NTS)  
          Copyright (c) The PHP Group  
          Zend Engine v4.1.2, Copyright (c) Zend Technologies  
          with Xdebug v3.1.3, Copyright (c) 2002-2022, by Derick Rethans`    
  NGINX : `nginx version: nginx/1.14`    
  MYSQL : `Ver 8.0.26`    
  REDIS SERVER : `Redis server v=6.2.6 sha=00000000:0 malloc=jemalloc-5.1.0 bits=64 build=117005704b7d572d`  
  MAIL TRAP : `mailhog/mailhog:v1.0.1`
**For the application to work, it is necessary to run dockerfile or docker-compose**
**To run on the system, docker and docker-compose must be installed**

---
# Note: All commands are executed in the directory where docker-compose.yml is located
### [host] your computer your system
### [docker] system installed in a docker, in a container
___
___
### Linux

1.[install docker ubuntu](https://docs.docker.com/engine/install/ubuntu/)  
2.[install docker-compose ubuntu](https://docs.docker.com/compose/install)

### WIN

1.[install docker win ??](https://docs.docker.com/docker-for-windows/install/)

**NOTE `<EXAMPLE>` To be replaced with the appropriate values**
**`exit 0` or `exit status 0` In linux it means `[OK]` any other number is an error**

## RUN APPLICATION

---
### ROAD MAP:

### First run

Build `./.env` the file from `./.env_example`  [host]
###Sometimes it doesn't work for commands on the host add 'sudo'  (`sudo docker ....`) in front
###Paste your application in the `/main`directory, server nginx will look for `index.php` in the `/main/public` directory
* terminal in host `docker-compose down` [host]
* terminal in host `docker-compose up --build` . [host]     
  **It works!**
- list container `docker ps`  (take the container id) [host]
- insert the id of the container you want to use `docker exec -it <CONTAINER_ID> bash` [host]
- terminal in container  `cd /main` [docker]
- terminal in container next `composer install -o`[docker]
- terminal in container end   `exit` out container terminal [docker]

### Next starts

`docker-compose up --build` or faster `docker-compose up` [host]

##**NOTE**

---

- in case of port conflicts, database name ... it is possible to change the value in the `./.env`  file in the
  .env_example**_ file

### Links according to the .env_example file:
NOTE: RUN `docker ps` The list will include the port, e.g. 8070:8080 the first is the host port, e.g. http://localhost:8070   
used in the browser should display a running application  
app: http://localhost:<WEB_PORT_LOCAL>  
database: localhost:<DB_PORT_LOCAL> user: <DB_USER>(test)   
password:<DB_PASSWORD>(1234) database:<DB_NAME>(test)


### Links according to the .env_example file:

NOTE: RUN `docker ps` The list will include the port, e.g. 8070:8080 the first is the host port, e.g. http://localhost:8070
used in the browser should display a running application
app: http://localhost:<WEB_PORT_LOCAL>
database: localhost:<DB_PORT_LOCAL> user: <DB_USER>(test)
password:<DB_PASSWORD>(1234) database:<DB_NAME>(test)
___
## WARNING

### All discovered passwords are examples, all addresses also apply to the local network, after deploying locally, they should be changed.

[mafio69](mailto:mf1969@gmail.com?subject=[GitHub]%20Docker%20Repo)
