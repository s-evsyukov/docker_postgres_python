# Docker Postgres Pscopg2

---
### Skills and tools:
`Docker` `Docker-compose` `PostgreSQL` `Adminer` `Python` `Pscorpg2`

---
### Task: Initiate Docker-compose container with PostgreSQL 

1. Pull and initiate Docker image with PostgreSQL
2. Pull and initiate Docker image with Adminer
3. Create Docker-compose configuration with next capability:
   * Database "Northwind" have to be initiated at start to PostgreSQL
   * Adminer can connect PostgreSQL and edit database inside docker container
   * PostgreSQL can be reached from host IP
   * Custom application have to run queri after database initialisation
4. Run custom application with next task:
 *Query how many units of products are on sale by product category in price equivalent. 
Show those that are more expensive than 5000*
5. Save image to DockerHub
---
### Progress of work:

1. [*Installing Docker*][1] infrastructure:

2. Configure Docker access:
 * add docker to group
 
[source, bash]
----
$ sudo groupadd docker 
----

 * add your user to the docker group:
```shell
$ sudo usermod -aG docker $USER
```
 * Check if docker belongs to your user group:
```shell
$ groups
docker adm cdrom sudo dip plugdev lpadmin lxd sambashare foo
```
3. [*Creating custom application*][2]: to run database queri
4. *Using* [*psycorpg2*][3] database adapter to connect app to PostgreSQL database
5. [*Configure import*][4] requirements for custom application
6. [*Download Northwind*][5] database sample to *./db* directory 
7. [*Creating Dockerfile*][6] to configure `Docker image` run steps
8. [*Creating Docker-compose.yaml*][7] to configure `Docker container` infrastructure
    * setting `Postgres` configuration with initialisation.db values(Northwind will be initialised at startup of database)
    * setting `Adminer` configuration 
    * setting Custom App configuration
    * `Docker-compose` will create default network to provide connection between application.
   We need to specify only ports to make application available from host.
9. Building image and running container with `docker-compose`:
```shell
 $ docker-compose up --build
```
9. Shutting down container:
```shell
$ docker-compose down --volumes
```
10. Renaming image and adding version tag:
```shell 
$ docker tag docker_postgres_app valknutt/docker_postgres_psycorpg2:v1.0
```
11. Creating repository with name *docker_postgres_psycorpg2* on `DockerHUB`

12. login to DockerHUB from terminal:
```shell
$ docker login --username ******** --pasword *********
```
13. [*Pushing image to DockerHUB*][8]:
```shell
$ docker push valknutt/docker_postgres_psycorpg2:v1.0
```
14. Cleaning local Docker containers
```shell 
$ docker container prune
```
15. Cleaning local Docker images
```shell 
$ docker images prune
```
16. Delete unused images if needed
```shell
$ docker images
$ docker rmi image_id 
```

[1]:https://docs.docker.com/engine/install/ubuntu/
[2]:https://github.com/Amboss/docker_postgres_python/blob/master/app/main.py
[3]:https://www.psycopg.org/docs/
[4]:https://github.com/Amboss/docker_postgres_python/blob/master/app/requirements.txt
[5]:https://github.com/yugabyte/yugabyte-db/blob/master/sample/northwind_data.sql
[6]:https://github.com/Amboss/docker_postgres_python/blob/master/Dockerfile
[7]:https://github.com/Amboss/docker_postgres_python/blob/master/docker-compose.yaml
[8]:https://hub.docker.com/repository/docker/valknutt/docker_postgres_psycopg2

