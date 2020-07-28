 
if (${env:APPDYNAMICS_CONTROLLER_SSL_ENABLED} -eq "true") { 
    $APPDYNAMICS_CONTROLLER_PROTOCOL = "https"
}
else {
    $APPDYNAMICS_CONTROLLER_PROTOCOL = "http"  
}
 
#Splatt the env variables 
$analytics_command_args = @{
    APPDYNAMICS_AGENT_APPLICATION_NAME    = "$env:APPDYNAMICS_AGENT_APPLICATION_NAME"
    APPDYNAMICS_CONTROLLER_PROTOCOL       = "$APPDYNAMICS_CONTROLLER_PROTOCOL"
    APPDYNAMICS_CONTROLLER_HOST_NAME      = "$env:APPDYNAMICS_CONTROLLER_HOST_NAME"
    APPDYNAMICS_CONTROLLER_PORT           = "$env:APPDYNAMICS_CONTROLLER_PORT"
    EVENT_ENDPOINT                        = "$env:EVENT_ENDPOINT"
    APPDYNAMICS_AGENT_ACCOUNT_NAME        = "$env:APPDYNAMICS_AGENT_ACCOUNT_NAME"
    APPDYNAMICS_AGENT_GLOBAL_ACCOUNT_NAME = "$env:APPDYNAMICS_AGENT_GLOBAL_ACCOUNT_NAME" 
    APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY  = "$env:APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY"
    APPDYNAMICS_ANALYTICS_AGENT_PORT      = "$env:APPDYNAMICS_ANALYTICS_AGENT_PORT"
    APPDYNAMICS_AGENT_PROXY_USER          = "$env:APPDYNAMICS_AGENT_PROXY_USER"
    APPDYNAMICS_AGENT_PROXY_PASS          = "$env:APPDYNAMICS_AGENT_PROXY_PASS"
    APPDYNAMICS_AGENT_PROXY_HOST          = "$env:APPDYNAMICS_AGENT_PROXY_HOST"
    APPDYNAMICS_AGENT_PROXY_PORT          = "$env:APPDYNAMICS_AGENT_PROXY_PORT"
}
 
if ([string]::IsNullOrEmpty(${env:APPDYNAMICS_AGENT_GLOBAL_ACCOUNT_NAME}) -or [string]::IsNullOrEmpty(${env:EVENT_ENDPOINT})) {
    Write-Host "Analytics is desired to be enabled, but requires account name and api url to be set"
    Write-Host "APPDYNAMICS_AGENT_GLOBAL_ACCOUNT_NAME or EVENT_ENDPOINT is not set"
    Get-ChildItem Env:
}
else {
    Write-Host "Basic conditions to enable analytics agent are met...."
    $command = "c:\appdynamics\updateAnalyticsAgentConfig.ps1" 
    & $command @analytics_command_args
    $analytics_path = "c:/appdynamics/analytics-agent-bundle-64bit-windows"
    Start-Process $analytics_path/jre/bin/java -ArgumentList "-jar $analytics_path/bin/tool/tool-executor.jar start" 

    # Make logs available in docker  logs when it's up, takes about 10 - 45 seconds if everything is OK 
    Start-Sleep -s 60
    while (!(Test-Path "$analytics_path/logs/analytics-agent.log")) { 
        $counter++
        Write-Host "Analytics agent is not up yet, there might be an issue. Please note that it requires a minimum of 1GB heap space to start. Please contact support@appadynamics.com if the issue persists". 
        Write-Host "The analytics agent container will continue to run to prevent the entire pod from crashing - to ensure your main container continues to server its purpose"
        Write-Host "The above decision was made on the basis that the standalone analytics agent is mostly deployed as a sidecar container"
        Write-Host ""
        Write-Host ""

        #sleep for 3.5 minutes and try again 
        Start-Sleep -s 20
        if ($counter -eq 3 -or $counter -eq 6 -or $counter -eq 9) {
          # Give it a try again, it normally fails due to insufficient heap, could be that things have settled after ~10 minutes. 
           Write-Host "attempting to start analytics agent again..."
          Start-Process $analytics_path/jre/bin/java -ArgumentList "-jar $analytics_path/bin/tool/tool-executor.jar start" 
          # then wait to see if it comes up before testing again.. 
          Start-Sleep -s 20 
        }
    } 
    Get-Content -Path "$analytics_path/logs/analytics-agent.log" -Tail  10 -Wait -ErrorAction Continue
}
 
 

