
FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]
ARG APPD_AGENT_VERSION 

LABEL name="AppDynamics Windows standalone analytics agent" \
      vendor="AppDynamics" \
      version="${APPD_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics monitoring solution for logs and transaction analytics " \
      description="AppDynamics monitoring solution for logs and transaction analytics"

ENV JAVA_HOME=c:\\appdynamics\\analytics-agent-bundle-64bit-windows\\jre

RUN mkdir c:/appdynamics

COPY updateAnalyticsAgentConfig.ps1 c:/appdynamics/updateAnalyticsAgentConfig.ps1

COPY start-agent.ps1 c:/appdynamics/start-agent.ps1

COPY analytics-agent-bundle-64bit-windows-${APPD_AGENT_VERSION}*.zip  c:/appdynamics

RUN "Expand-Archive -Path c:/appdynamics/analytics-agent-bundle-64bit-windows-${APPD_AGENT_VERSION}*.zip -DestinationPath c:/appdynamics"

#clean up without prompt
RUN "Remove-Item -Path c:/appdynamics/analytics-agent-bundle-64bit-windows-${APPD_AGENT_VERSION}*.zip -Force"

WORKDIR ${JAVA_HOME}

ENTRYPOINT ["powershell","c:\\appdynamics\\start-agent.ps1"]
