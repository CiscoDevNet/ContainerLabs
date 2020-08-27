#!/bin/bash
AGENT_VER="20.8.0.2388"
if [ "x${APPDYNAMICS_AGENT_VERSION}" != "x" ]; then
    AGENT_VER=${APPDYNAMICS_AGENT_VERSION}
fi

pip install -U appdynamics==${AGENT_VER}

AGENT_CONFIG="/opt/appdynamics/agent.cfg"
if [ "x${APPDYNAMICS_AGENT_CONFIG}" != "x" ]; then
    AGENT_CONFIG=${APPDYNAMICS_AGENT_CONFIG}
fi

if [ "x${APP_ENTRY_POINT}" = "x" ]; then
	echo  "APP_ENTRY_POINT variable must be set. Aborting..."
	exit 1
fi

ENTRY_POINT=${APP_ENTRY_POINT}


AGENT_PROXY=""

if [ "x${APPD_PROXY_CONTROL_PATH}" != "x" ]; then
	mkdir -p ${APPD_PROXY_CONTROL_PATH}
	chmod 755 ${APPD_PROXY_CONTROL_PATH}
    AGENT_PROXY="--use-manual-proxy"
fi

pyagent run $AGENT_PROXY -c $AGENT_CONFIG  $ENTRY_POINT