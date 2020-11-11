
FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]
ARG APPDYNAMICS_AGENT_VERSION 

LABEL name="AppDynamics Windows DB Agent" \
      vendor="AppDynamics" \
      version="${APPDYNAMICS_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics monitoring solution for Databases" \
      description="AppDynamics monitoring solution for Databases"

# set environment variables
ENV APPDYNAMICS_AGENT_VERSION=$APPDYNAMICS_AGENT_VERSION
ENV APPDYNAMICS_DB_AGENT_HOME=c:\\appdynamics\\dbagent
ENV JAVA_HOME=c:\\appdynamics\\dbagent\\jre

# make an agent directory
RUN mkdir ${env:APPDYNAMICS_DB_AGENT_HOME}

# copy start agent script
COPY start-agent.ps1 "c:\\appdynamics\\start-agent.ps1"
# copy agent files
COPY db-agent-64bit-windows-$APPD_AGENT_VERSION*.zip $APPDYNAMICS_DB_AGENT_HOME

RUN "Expand-Archive -Path ${env:APPDYNAMICS_DB_AGENT_HOME}\\db-agent-64bit-windows-${APPD_AGENT_VERSION}*.zip -DestinationPath ${env:APPDYNAMICS_DB_AGENT_HOME}"

# clean up without prompt
RUN "Remove-Item -Path ${env:APPDYNAMICS_DB_AGENT_HOME}\\db-agent-64bit-windows-${APPDYNAMICS_AGENT_VERSION}*.zip"

WORKDIR "${APPDYNAMICS_DB_AGENT_HOME}"

#RUN "Write-Host ${env:APPDYNAMICS_AGENT_VERSION}"
RUN "ls ${env:APPDYNAMICS_DB_AGENT_HOME}"

ENTRYPOINT ["pwsh","c:\\appdynamics\\start-agent.ps1"]
