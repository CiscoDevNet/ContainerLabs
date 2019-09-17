#!/bin/sh

PROXY_CTRL_DIR="/tmp/ad-ctrl"

if [ "x${APPD_PROXY_CONTROL_PATH}" != "x" ]; then
    PROXY_CTRL_DIR=${APPD_PROXY_CONTROL_PATH}
fi

PROXY_HOME_DIR="/opt/appdynamics/php-agent/proxy"
mkdir -p /opt/appdynamics/logs

httpProxyHost=${APPDYNAMICS_AGENT_PROXY_HOST}
httpProxyPort=${APPDYNAMICS_AGENT_PROXY_PORT}
httpProxyUser=${APPDYNAMICS_AGENT_PROXY_USER}
httpProxyPasswordFile=${APPDYNAMICS_AGENT_PROXY_PASS}


statFormatOpt="--format="
runProxyScript="${PROXY_HOME_DIR}/runProxy"

runProxyTemplate="${runProxyScript}.template"
runProxyTemplateOwner=$(stat "${statFormatOpt}%u" "${runProxyTemplate}")
runProxyTemplateGroup=$(stat "${statFormatOpt}%g" "${runProxyTemplate}")
log "Writing '${runProxyScript}'"
cat "${runProxyTemplate}" | \
    sed -e "s/^httpProxyHost=\$/httpProxyHost=\"${httpProxyHost}\"/" \
        -e "s/^httpProxyPort=\$/httpProxyPort=${httpProxyPort}/" \
        -e "s/^httpProxyUser=\$/httpProxyUser=${httpProxyUser}/" \
        -e "s|^httpProxyPasswordFile=\$|httpProxyPasswordFile=${httpProxyPasswordFile}|" \
        > "${runProxyScript}"
chown "${runProxyTemplateOwner}" "${runProxyScript}"
chgrp "${runProxyTemplateGroup}" "${runProxyScript}"
chmod a+rx "${runProxyScript}"

${runProxyScript} ${PROXY_CTRL_DIR} /opt/appdynamics/logs



