#!/bin/bash
AGENT_VER="4.5.4.0"
if [ "x${APPDYNAMICS_AGENT_VERSION}" != "x" ]; then
    AGENT_VER=${APPDYNAMICS_AGENT_VERSION}
fi

pip install -U appdynamics==${AGENT_VER}

AGENT_CONFIG="/opt/appdynamics/agent.cfg"
if [ "x${APPDYNAMICS_AGENT_CONFIG}" != "x" ]; then
    AGENT_CONFIG=${APPDYNAMICS_AGENT_CONFIG}
fi

ENTRY_POINT=" python app/app.py"

if [ "x${APP_ENTRY_POINT}" != "x" ]; then
    ENTRY_POINT=${APP_ENTRY_POINT}
fi

AGENT_PROXY=""

if [ "x${APPD_PROXY_CONTROL_PATH}" != "x" ]; then
	mkdir -p ${APPD_PROXY_CONTROL_PATH}
	chmod 755 ${APPD_PROXY_CONTROL_PATH}
    AGENT_PROXY="--use-manual-proxy"
fi

pyagent run $AGENT_PROXY -c $AGENT_CONFIG  $ENTRY_POINT