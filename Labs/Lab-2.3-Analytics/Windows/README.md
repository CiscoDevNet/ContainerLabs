**Build your own image**


Download the latest Windows 64Bit bundled standalone analytics agent from the [AppDynamics Official Download Site](https://download.appdynamics.com/download/). 

Toss the downloaded zip file into `container` folder and note the agent version number (e.g `20.6.1`) from the downloaded zip file.

Locate the `build.ps1` script in the `container` folder

Run `./build.ps1` passing the version, as it appears in the name of the zip file, like this:

`build.ps1 -agentVersion <version-number> -dockerHubHandle <docker-hub-name>`

Where :

-  `version-number` is the agent version to be used for tagging. You must tag the image.

-  `docker-hub-handle` is the image reference, for example, if I want to push the image to my private dockerhub repo, I'd use `iogbole` as the `dockerHubHandle` in the build parameter.  This is an optional field and it defaults to `appdynamics`

Please refer to the `env.list` file to see the supported environment variables. 

The Kubernetes Cluster Agent's configMap has all the required environment variables set. Use the same ConfigMap if you're using the Cluster Agent.

Since this image only applies to Windows Container, you  would need to define the appropriate nodeSelectors and tolerations in your deployment manifest.
