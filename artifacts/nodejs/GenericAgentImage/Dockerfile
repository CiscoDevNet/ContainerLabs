FROM alpine

ARG NODE_AGENT_VERSION 

MAINTAINER <you>@appdynamics.com

LABEL name="AppDynamics Node.js Agent" \
      vendor="AppDynamics" \
      version="${NODE_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics solution for monitoring Node.js applications" \
      description="AppDynamics agent for monitoring Node.js applications"


COPY agent/ /opt/appdynamics

WORKDIR /opt/appdynamics

CMD [ "echo", "Just delivering the Node.js Agent. Use me in Init Containers in Kubernetes." ]