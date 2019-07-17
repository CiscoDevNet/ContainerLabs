package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/ClientAPI")
public class ClientAPIController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from ClientAPI:home()";
    }

	@RequestMapping("/updateAction")
	public String updateAction(HttpServletRequest request) {
		makeWebRequest("action-response-services", "8001", "actionResponseServices/updateAction", request);
		makeWebRequest("world-change-services", "8080", "WorldChangeServices/updateAction", request);
		return "Hello from updateAction";
	}

	@RequestMapping("/chat")
	public String chat(HttpServletRequest request) {
		makeWebRequest("action-response-services", "8001", "actionResponseServices/chat", request);
		return "Hello from chat";
	}

	@RequestMapping("/getWorld")
	public String getWorld(HttpServletRequest request) {
		makeWebRequest("world-change-services", "8080", "WorldChangeServices/getWorld", request);
		return "Hello from getWorld";
	}


}