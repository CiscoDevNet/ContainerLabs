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

$IMAGE_NAME = "$dockerHubHandle/analytics-agent"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "
Write-Host "winTag = $winTag "

docker build --no-cache --build-arg APPD_AGENT_VERSION=$agentVersion -t ${IMAGE_NAME}:$agentVersion-$winTag . 
 
# run it like this 
#docker run -d --env-file env.list.local ${IMAGE_NAME}:$agentVersion

# get the containerID
#docker ps 

# exec into it like this 
#docker exec -it <containerID>  pwsh
