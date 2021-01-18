resource "kubernetes_config_map" "ma_log_config" {
  metadata {
    name = "ma-log-config"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  data = {
    "log4j.xml" = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<configuration status=\"Warn\" monitorInterval=\"30\">\n\n    <Appenders>\n        <Console name=\"ConsoleAppender\" target=\"SYSTEM_OUT\">\n            <PatternLayout pattern=\"%d{ABSOLUTE} %5p [%t] %c{1} - %m%n\"/>\n        </Console>\n\n        <RollingFile name=\"FileAppender\" fileName=\"$${log4j:configParentLocation}/../../logs/machine-agent.log\"\n                     filePattern=\"$${log4j:configParentLocation}/../../logs/machine-agent.log.%i\">\n            <PatternLayout>\n                <Pattern>[%t] %d{DATE} %5p %c{1} - %m%n</Pattern>\n            </PatternLayout>\n            <Policies>\n                <SizeBasedTriggeringPolicy size=\"5000 KB\"/>\n            </Policies>\n            <DefaultRolloverStrategy max=\"5\"/>\n        </RollingFile>\n    </Appenders>\n\n    <Loggers>\n        <Logger name=\"com.singularity\" level=\"info\" additivity=\"false\">\n            <AppenderRef ref=\"FileAppender\"/>\n        </Logger>\n        <Logger name=\"com.appdynamics\" level=\"info\" additivity=\"false\">\n            <AppenderRef ref=\"FileAppender\"/>\n        </Logger>\n        <Logger name=\"com.singularity.ee.agent.systemagent.task.sigar.SigarAppAgentMonitor\" level=\"info\" additivity=\"false\">\n            <AppenderRef ref=\"FileAppender\"/>\n        </Logger>\n        <Root level=\"error\">\n            <AppenderRef ref=\"FileAppender\"/>\n        </Root>\n    </Loggers>\n\n</configuration>\n"
  }
}

