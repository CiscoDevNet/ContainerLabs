#!/bin/bash

mvn clean package -DskipTests=true

cp ./target/java-services.jar ./docker/java-services.jar

docker build -t java-services -f docker/Dockerfile ./docker
