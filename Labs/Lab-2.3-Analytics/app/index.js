require('appdynamics').profile({
    controllerHostName: process.env.APPDYNAMICS_CONTROLLER_HOST_NAME,
    controllerPort: process.env.APPDYNAMICS_CONTROLLER_PORT,
    controllerSslEnabled: ((process.env.APPDYNAMICS_CONTROLLER_SSL_ENABLED || "false") == "true"),
    accountName: process.env.APPDYNAMICS_AGENT_ACCOUNT_NAME,
    accountAccessKey: process.env.APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY,
    applicationName: process.env.APPDYNAMICS_AGENT_APPLICATION_NAME,
    tierName: process.env.APPDYNAMICS_AGENT_TIER_NAME,
    nodeName: process.env.APPDYNAMICS_AGENT_TIER_NAME + "-1",
    analytics: {
        host: process.env.APPDYNAMICS_ANALYTICS_HOST,
        port: Number(process.env.APPDYNAMICS_ANALYTICS_PORT)
    },
    libagent: true
});

var authServices = require("./services/auth-services.js");
var flightServices = require("./services/flight-services.js");
var offerServices = require("./services/offer-services.js");
var searchServices = require("./services/search-services.js");

var main = function() {
    
    if (process.env.APPDYNAMICS_AGENT_TIER_NAME == "auth-services") {
        authServices.main();
    }
    else if (process.env.APPDYNAMICS_AGENT_TIER_NAME == "flight-services") {
        flightServices.main();
    }
    else if (process.env.APPDYNAMICS_AGENT_TIER_NAME == "offer-services") {
        offerServices.main();
    }
    else if (process.env.APPDYNAMICS_AGENT_TIER_NAME == "search-services") {
        searchServices.main();
    }
}

main();
