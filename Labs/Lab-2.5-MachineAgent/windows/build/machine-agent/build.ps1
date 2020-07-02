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
    $winTag = "win-ltsc2019"
 }

$IMAGE_NAME = "$dockerHubHandle/machine-agent-analytics"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "
Write-Host "winTag = $winTag "

docker build --no-cache --build-arg APPD_AGENT_VERSION=$agentVersion -t ${IMAGE_NAME}:$agentVersion-$winTag . 
 
