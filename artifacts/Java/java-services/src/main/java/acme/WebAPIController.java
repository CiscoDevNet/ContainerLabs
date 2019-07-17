package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/WebAPI")
public class WebAPIController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from WebAPI:home()";
    }

	@RequestMapping("/login")
	public String login() {
		return "Hello from login";
	}

	@RequestMapping("/purchaseGamePass")
	public String purchaseGamePass(HttpServletRequest request) {
		makeWebRequest("billing-services", "8080", "BillingServices/purchaseGamePass", request);
		makeWebRequest("world-portal", "8080", "WorldPortal/purchaseGamePass", request);
		return "Hello from purchaseGamePass";
	}

	@RequestMapping("/joinGame")
	public String joinGame(HttpServletRequest request) {
		makeWebRequest("world-portal", "8080", "WorldPortal/joinGame", request);
		return "Hello from joinGame";
	}


}