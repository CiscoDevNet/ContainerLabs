{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
FROM mcr.microsoft.com/windows/servercore:ltsc2019\
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]\
ARG APPD_AGENT_VERSION \
\
LABEL name="AppDynamics Windows Infra Viz Agent" \\\
      vendor="AppDynamics" \\\
      version="$\{APPD_AGENT_VERSION\}" \\\
      release="1" \\\
      url="https://www.appdynamics.com" \\\
      summary="AppDynamics monitoring solution for Kubernetes Windows worker nodes" \\\
      description="AppDynamics monitoring solution for Kubernetes Windows worker nodes"\
\
ENV APPDYNAMICS_MACHINE_AGENT_HOME=c:\\\\appdynamics\\\\machineagent\
    \
RUN mkdir  "$\{env:APPDYNAMICS_MACHINE_AGENT_HOME\}"\
\
COPY updateAnalyticsAgentConfig.ps1 c:/appdynamics/updateAnalyticsAgentConfig.ps1\
\
COPY start-agent.ps1 c:/appdynamics/start-agent.ps1\
\
COPY machineagent-bundle-64bit-windows-$\{APPD_AGENT_VERSION\}*.zip  c:/appdynamics\
\
RUN "ls c:\\appdynamics"\
\
RUN "Expand-Archive -Path c:/appdynamics/machineagent-bundle-64bit-windows-$\{APPD_AGENT_VERSION\}*.zip -DestinationPath $\{env:APPDYNAMICS_MACHINE_AGENT_HOME\}"\
\
#clean up without prompt\
RUN "Remove-Item -Path c:/appdynamics/machineagent-bundle-64bit-windows-$\{APPD_AGENT_VERSION\}*.zip -Force"\
\
WORKDIR "$\{APPDYNAMICS_MACHINE_AGENT_HOME\}"\
\
RUN "ls $\{env:APPDYNAMICS_MACHINE_AGENT_HOME\}"\
\
ENTRYPOINT ["powershell","c:\\\\appdynamics\\\\start-agent.ps1"]\
}