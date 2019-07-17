Application Server Agent Installation
-------------------------------------

An unzipped directory structure of Appdynamics Agent can be used for single
JVM or multiple JVM installation.

1. Follow the comments to specify the values in controller-info.xml (in the
   conf directory of the agent installation directory) to start monitoring
   requests on this jvm node.

   All values that need to be specified in that XML can be specified as
   system properties also, the values can be found against the corresponding
   tags.

2. Edit the script that starts your app server and add a java agent argument.

   You need to add the following as a java startup option/argument:

   -javaagent:<agent_install_dir>/javaagent.jar

   The objective is to have a startup line something like the following:

   java -javaagent:/usr/local/agent/javaagent.jar -Dprop=val com.foo.MyAppserver

   It is recommended that the application server be shutdown during this
   installation.


3. Make sure the user running the app server process has full permissions on the
   agent installation directory, including its subdirectories. This is needed
   for reading configuration files and writing to agent log files. Optionally
   you may specify an agent-runtime-dir as agent's output directory for logs and
   configuration.

4. Verify that the agent has been installed correctly.

   The Application server has to be restarted/started for the install to be
   effective.

   Check that you have received the following message that the java agent was
   started successfully in the agent-<timestamp>.0.log file in your
   <agent_install_dir>/logs/<node-name>/agent.log folder when you start the
   application server.

   'Started AppDynamics Java Agent Successfully'.

Redirecting Log Files
-----------------------

By default log files for the agent are written to
    <agent_install_dir>/logs/<node-name>
or if agent runtime directory is specified <agent-runtime-dir>/logs/<node-name>

The log files written by the agent can be redirected to a different folder by
using the system property '-Dappdynamics.agent.logs.dir' and specifying the
absolute path or relative path of a different directory.


Connecting to the Controller through a Proxy Server
--------------------------------------------------

Use the following system properties to set the host and port of the proxy server
so that it can route requests to the controller.

-Dappdynamics.http.proxyHost=<host>
-Dappdynamics.http.proxyPort=<port>


Specifying custom host name
---------------------------

The host name for the machine on which the Agent is running is used as an
identifying property for the Agent Node. If the machine host name is not
constant or if you prefer to use a specific name of your choice, please specify
the following system property as part of your startup command.

-Dappdynamics.agent.uniqueHostId=<host-name>


Mandatory fields
----------------

The application, tier and node names are mandatory. They must be specified in
the controller-info.xml or as system properties from the command line.

Alternatively, a unique identifier can be provided as a -javaagent option so
that the Java agent can auto-name the application (auto-named to MyApp), tier
(auto-named to the uniqueID value) and node (auto-named to the uniqueID value).

Example:
-javaagent <AGENT_HOME>/javaagent.jar=uniqueID=<YOUR_JVM_NAME>

For more information, see Java Agent installation instructions at
https://docs.appdynamics.com
