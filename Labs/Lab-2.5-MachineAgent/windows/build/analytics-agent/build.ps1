{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red105\green105\blue105;\red0\green191\blue255;\red0\green0\blue139;
\red168\green45\blue0;\red0\green97\blue97;\red139\green0\blue0;\red0\green0\blue255;\red138\green43\blue226;
\red0\green0\blue128;}
{\*\expandedcolortbl;;\csgenericrgb\c41176\c41176\c41176;\csgenericrgb\c0\c74902\c100000;\csgenericrgb\c0\c0\c54510;
\csgenericrgb\c65882\c17647\c0;\csgenericrgb\c0\c38039\c38039;\csgenericrgb\c54510\c0\c0;\csgenericrgb\c0\c0\c100000;\csgenericrgb\c54118\c16863\c88627;
\csgenericrgb\c0\c0\c50196;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs24 \cf0  
\fs18 \cf2 [\cf3 cmdletbinding\cf0 ()\cf2 ]\cf0 \
\cf4 Param\cf0  (\
    \cf2 [\cf3 Parameter\cf0 (Mandatory \cf2 =\cf0  \cf5 $true\cf0 )\cf2 ]\cf0 \
    \cf2 [\cf6 string\cf2 ]\cf5 $agentVersion\cf2 ,\cf0 \
\
     \cf2 [\cf3 Parameter\cf0 (Mandatory \cf2 =\cf0  \cf5 $false\cf0 )\cf2 ]\cf0 \
    \cf2 [\cf6 string\cf2 ]\cf5 $dockerHubHandle\cf2 ,\cf0 \
\
     \cf2 [\cf3 Parameter\cf0 (Mandatory \cf2 =\cf0  \cf5 $false\cf0 )\cf2 ]\cf0 \
    \cf2 [\cf6 string\cf2 ]\cf5 $winTag\cf0 \
)\
\
\cf4 if\cf0  (\cf5 $dockerHubHandle\cf0  \cf2 -eq\cf0  \cf7 ""\cf0 ) \{\
    \cf5 $dockerHubHandle\cf0  \cf2 =\cf0  \cf7 "appdynamics"\cf0 \
 \}\
\
\cf4 if\cf0  (\cf5 $winTag\cf0  \cf2 -eq\cf0  \cf7 ""\cf0 ) \{\
    \cf5 $winTag\cf0  \cf2 =\cf0  \cf7 "win-ltsc2019"\cf0 \
 \}\
\
\cf5 $IMAGE_NAME\cf0  \cf2 =\cf0  \cf7 "\cf5 $dockerHubHandle\cf7 /analytics-agent"\cf0 \
\
\cf8 Write-Host\cf0  \cf7 "version = \cf5 $agentVersion\cf7  "\cf0 \
\cf8 Write-Host\cf0  \cf7 "dockerHubHandle = \cf5 $dockerHubHandle\cf7  "\cf0 \
\cf8 Write-Host\cf0  \cf7 "winTag = \cf5 $winTag\cf7  "\cf0 \
\
\cf8 docker\cf0  \cf9 build\cf0  \cf9 --no-cache\cf0  \cf9 --build-arg\cf0  \cf9 APPD_AGENT_VERSION=\cf5 $agentVersion\cf0  \cf10 -t\cf0  \cf5 $\{IMAGE_NAME\}\cf9 :\cf5 $agentVersion\cf9 -\cf5 $winTag\cf0  \cf9 .\cf0  \
 \
}