FROM openjdk:8-jre-slim

RUN apt-get update && \
    apt-get install -y procps binutils vim curl && \
    apt-get clean

COPY ./java-services/docker/startup.sh /startup.sh

COPY AppServerAgent/ /opt/appdynamics/

RUN chmod +x /startup.sh

RUN chmod +w /etc/resolv.conf


ADD ./java-services/docker/java-services.jar java-services.jar

ENTRYPOINT ["/bin/bash", "/startup.sh"]
