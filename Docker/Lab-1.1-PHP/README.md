# Instrument PHP app with appdynamics php-agent in docker (opencart)

## docker-compose

1. Download php-agent and extract to project subdir  `./php-agent/appdynamics-php-agent-x64-linux`

2. Set up `./php-agent/.env` file with controller settings:


```shell
APP_ENTRY_POINT=/app-entrypoint.sh httpd -f /opt/bitnami/apache/conf/httpd.conf -DFOREGROUND
# PHP_INI_DIR=/etc/php/7.2/fpm/conf.d
APPDYNAMICS_AGENT_ACCOUNT_NAME=customer1
APPDYNAMICS_AGENT_APPLICATION_NAME=Opencart
APPDYNAMICS_AGENT_TIER_NAME=Frontend
APPDYNAMICS_NODE_NAME=Frontend-1
APPDYNAMICS_CONTROLLER_HOST_NAME=<controler host>
APPDYNAMICS_CONTROLLER_PORT=8090
APPDYNAMICS_CONTROLLER_SSL_ENABLED=false
APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=<access key here>
```

You would need to get `APP_ENTRY_POINT` of app you are instrumenting to properly start the app after agent installation script. Check Dockerfile of original image. In case of opencart it can be found here:

https://github.com/bitnami/bitnami-docker-opencart/blob/master/3/debian-10/Dockerfile

This is not required for opencart, but in case of php-fpm, you may set `PHP_INI_DIR` to path of fpm configuration directory or otherwise agent might be installed to PHP CLI.

3. In `docker-compose.yml` add volume mounts and `env_file`. Also overwrite `command` with `/bin/sh /opt/appdynamics/start.sh`

```shell
version: '2'
services:
  mariadb:
    image: 'docker.io/bitnami/mariadb:10.3-debian-10'
    environment:
      - MARIADB_USER=bn_opencart
      - MARIADB_DATABASE=bitnami_opencart
      - ALLOW_EMPTY_PASSWORD=yes
    volumes:
      - 'mariadb_data:/bitnami'
  opencart:
    image: 'docker.io/bitnami/opencart:3-debian-10'
    environment:
      - MARIADB_HOST=mariadb
      - MARIADB_PORT_NUMBER=3306
      - OPENCART_DATABASE_USER=bn_opencart
      - OPENCART_DATABASE_NAME=bitnami_opencart
      - OPENCART_HOST=localhost
      - ALLOW_EMPTY_PASSWORD=yes
    env_file:                     # add this line
     - ./php-agent/.env # add this line
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - 'opencart_data:/bitnami'
      - ./php-agent/appdynamics-php-agent-linux_x64:/opt/appdynamics/php-agent # add this line
      - ./php-agent/start.sh:/opt/appdynamics/start.sh # add this line
      - ./php-agent/appdynamics_agent.ini:/opt/appdynamics/php-agent/php/conf/appdynamics_agent.ini #add this line
    command: /bin/sh /opt/appdynamics/start.sh # add this line
    depends_on:
      - mariadb
volumes:
  mariadb_data:
    driver: local
  opencart_data:
    driver: local
```


4. Start docker-compose from opencart dir:
`docker-compose up`

5. When finished purge project (including volumes and network)
`docker-compose down -v`

## Analytics

To enable analytics, edit ./php-agent/appdynamics_agent.ini file. You can start analytics-agent as in Lab-1.3-MachineAgent
and point php-agent to MA endpoint. Make sure they are on the same docker network or use host ip.


## Bonus: without docker-compose

you can also run instrumentation as the docker command

```shell
docker run \
--env-file=${PWD}/php-agent/.env \
-v ${PWD}/php-agent/appdynamics-php-agent-x64-linux:/opt/appdynamics/php-agent \
-v ${PWD}/php-agent/start.sh:/opt/appdynamics/start.sh \
-v ${PWD}/php-agent/appdynamics_agent.ini:/opt/appdynamics/php-agent/php/conf/appdynamics_agent.ini \
myimage:latest \
/bin/sh /opt/appdynamics/start.sh
```

## Links

https://hub.docker.com/r/bitnami/opencart/
