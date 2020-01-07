#!/bin/bash

JAVA_OPTS="$JAVA_OPTS -Xms64m -Xmx512m -XX:MaxPermSize=256m -Djava.net.preferIPv4Stack=true"
JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"

UNIQUE_HOST_ID=$(sed -rn '1s#.*/##; 1s/(.{12}).*/\1/p' /proc/self/cgroup)

JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.uniqueHostId=$UNIQUE_HOST_ID"

exec java $JAVA_OPTS -jar /java-services.jar