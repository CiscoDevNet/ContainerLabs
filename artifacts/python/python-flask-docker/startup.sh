#!/bin/bash

PROXY_DIR="/tmp/appd/run"
if [ "x${APPD_PROXY_CONTROL_PATH}" != "x" ]; then
    PROXY_DIR=${APPD_PROXY_CONTROL_PATH}
fi

mkdir -p ${PROXY_DIR}
chmod 755 ${PROXY_DIR}

AGENT_VER="4.5.4.0"
if [ "x${APPDYNAMICS_AGENT_VERSION}" != "x" ]; then
    AGENT_VER=${APPDYNAMICS_AGENT_VERSION}
fi

pip install -U appdynamics==${AGENT_VER}


pyagent proxy start
while :
do
	sleep 1
done