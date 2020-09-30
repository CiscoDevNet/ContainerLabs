**Build your own image**

## container

Download the latest Windows 64Bit bundled standalone database agent from the [AppDynamics Official Download Site](https://download.appdynamics.com/download/). 

Toss the downloaded zip file into `container` folder and note the agent version number (e.g `20.6.1`) from the downloaded zip file.

Locate the `build.ps1` script in the `container` folder

Run `./build.ps1` passing the version, as it appears in the name of the zip file, like this:

`build.ps1 -agentVersion <version-number> -dockerHubHandle <docker-hub-name>`

Where :

-  `version-number` is the agent version to be used for tagging. You must tag the image.

-  `docker-hub-handle` is the image reference, for example, if I want to push the image to my private DockerHub repo, I'd use `alexappd` as the `dockerHubHandle` in the build parameter.  This is an optional field and it defaults to `appdynamics`

Please refer to the `env.list` file to see the supported environment variables. 

## k8-manifests

The Kubernetes configMap has all the required environment variables set.

Update secrets file with your controller's secret access key and set this base 64 encoded value for the 'appd-access-key' key.

In manifest, update the container specification to refer to the image that you built in a previous steps, also you can override any environment variables here.
