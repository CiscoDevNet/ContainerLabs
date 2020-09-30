[cmdletbinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string]$agentVersion,

    [Parameter(Mandatory = $false)]
    [string]$dockerHubHandle,

    [Parameter(Mandatory = $false)]
    [string]$winTag
)

if ($dockerHubHandle -eq "") {
    $dockerHubHandle = "appdynamics"
}

if ($winTag -eq "") {
    $winTag = "win-nano"
 }

$imageName = "$dockerHubHandle/db-agent"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "
Write-Host "winTag = $winTag "

# 1. Build
docker build --no-cache --build-arg APPDYNAMICS_AGENT_VERSION=$agentVersion -t ${imageName}:$agentVersion-$winTag . 

# 2. Run (with env)
docker run -d --env-file env.list.local ${imageName}:$agentVersion-$winTag

# 3. Push
#docker push ${imageName}:$agentVersion-$winTag

# docker run -d --env-file env.list.local alexappd/db-agent:20.7.0.1892-win-nano
# docker push alexappd/db-agent:20.7.0.1892-win-nano
# core: docker exec -it container_id powershell 
# nano: docker exec -it container_id pwsh
# ./build.ps1 -agentVersion "20.7.0.1892" -dockerHubHandle alexappd    