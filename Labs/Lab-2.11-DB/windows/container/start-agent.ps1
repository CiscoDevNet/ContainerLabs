
if ([string]::IsNullOrEmpty(${env:APPDYNAMICS_DB_AGENT_HOME})) {
   $DB_HOME = "c:\\appdynamics\\dbagent"
} else {
   $DB_HOME = "${env:APPDYNAMICS_DB_AGENT_HOME}"
}

if ([string]::IsNullOrEmpty(${env:JAVA_HOME})) {
   $JAVA_HOME = "c:\\appdynamics\\dbagent\\jre"
} else {
   $JAVA_HOME = "${env:JAVA_HOME}"
}

$JAVA_FILE_PATH=[string]::Format("{0}\\bin\\java.exe",$JAVA_HOME)

# start database agent
Start-Process -FilePath $JAVA_FILE_PATH -ArgumentList "-Djava.library.path=""$DB_HOME\auth\x64"" -jar $DB_HOME\\db-agent.jar"   

# Make logs available in docker when it's started up, takes about 10 -15 seconds
Start-Sleep -s 30
Get-Content -Path "$DB_HOME\logs\agent.log" -Tail 10 -Wait -ErrorAction Continue

