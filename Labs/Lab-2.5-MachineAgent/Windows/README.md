**Build your own image**


Download the latest Windows 64Bit bundled Machine Agent from the [AppDynamics Official Download Site](https://download.appdynamics.com/download/)


Note the agent version number (e.g `20.6.1`) from the downloaded zip file.

  

Locate the `build.ps1` script in the `container` folder

  

Run `./build.ps1` passing the version, as it appears in the name of the zip file, like this:

  

`build.ps1 -agentVersion <version-number> -dockerHubHandle <docker-hub-name>`

Where :

  

-  `version-number` is the agent version to be used for tagging. You must tag the image.

-  `docker-hub-handle` is the image reference, for example, if I want to push the image to my private dockerhub repo, I'd use `iogbole` as the `dockerHubHandle` in the build parameter.  This is an optional field and it defaults to `appdynamics`

Please refer to the `env.list` file to see the supported environment variables.

You may use the Infra viz operator in the Kubernetes Cluster Agent to deploy this image as a daemonset to your Windows worker nodes. To do this, you would need to define the appropriate nodeSelectors and tolerations. In addition, you'd need to define the following environment variables in your Kubernetes manifest should you need to use any of it as the Infra viz operator does not set them:

> APPDYNAMICS_AGENT_HTTPS_PROXY_PORT <br>
> APPDYANMICS_AGENT_PROXY_PASSWORD_FILE <br>
> APPDYNAMICS_AGENT_HTTPS_PROXY_PORT <br>
> APPDYNAMICS_AGENT_HTTPS_PROXY_HOST <br>
> APPDYNAMICS_AGENT_UNIQUE_HOST_ID #defaults to containerID  <br>
> APPDYNAMICS_DOTNET_COMPATIBILITY_MODE #defaults to true  <br> 
> APPDYNAMICS_ANALYTICS_AGENT_PORT #defaults to 9090   <br>
> APPDYNAMICS_ENABLE_ANALYTICS_AGENT #defaults to true
