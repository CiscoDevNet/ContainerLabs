AGENT_CONFIG_MOUNT="/opt/appd/AppDynamicsConfig-temp.json"
AGENT_CONFIG_TEMPLATE="/opt/appd/AppDynamicsConfig.json.template"
AGENT_CONFIG="/opt/appd/AppDynamicsConfig.json"

replaceText () {

 sed -i "s|$1|$2|g" $3
}

# obtain container id for uniquehost id. Note, this command is for Kubernetes/Docker environments
APPDYNAMICS_AGENT_UNIQUE_HOST_ID=$(sed -rn '1s#.*/##; 1s/(.{12}).*/\1/p' /proc/self/cgroup)
echo 'Unique host id = ' $APPDYNAMICS_AGENT_UNIQUE_HOST_ID

#copy the mounted config into the template file
cp -f $AGENT_CONFIG_MOUNT $AGENT_CONFIG_TEMPLATE
echo 'Copied the mounted file'

#assign unique host id value
replaceText 'APPDYNAMICS_AGENT_UNIQUE_HOST_ID' $APPDYNAMICS_AGENT_UNIQUE_HOST_ID  $AGENT_CONFIG_TEMPLATE
echo 'Assigned Unique Host ID value'

#rename the template file
mv $AGENT_CONFIG_TEMPLATE $AGENT_CONFIG
echo 'Renamed the template file. Ready to initialize the agent'
