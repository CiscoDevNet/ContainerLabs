FROM node:10.16.0-alpine as installer

ARG NODE_AGENT_VERSION 

WORKDIR /opt/appdynamics

RUN npm install appdynamics@${NODE_AGENT_VERSION}

COPY shim.js /opt/appdynamics

FROM alpine

MAINTAINER you@appdynamics.com

LABEL name="AppDynamics Node.js Agent" \
      vendor="AppDynamics" \
      version="${NODE_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics solution for monitoring Node.js applications" \
      description="AppDynamics agent for monitoring Node.js applications"


COPY --from=installer /opt/appdynamics /opt/appdynamics

CMD [ "echo", "Just delivering the Node.js Agent. Use me in Init Containers in Kubernetes." ]