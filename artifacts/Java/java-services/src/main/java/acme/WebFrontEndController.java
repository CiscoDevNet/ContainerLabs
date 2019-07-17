package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/WebFrontEnd")
public class WebFrontEndController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from WebFrontEnd:home()";
    }

	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		makeWebRequest("auth-services", "8080", "AuthServices/login", request);
		makeWebRequest("web-api", "8080", "WebAPI/login", request);
		return "Hello from login";
	}

	@RequestMapping("/purchaseGamePass")
	public String purchaseGamePass(HttpServletRequest request) {
		makeWebRequest("web-api", "8080", "WebAPI/purchaseGamePass", request);
		return "Hello from purchaseGamePass";
	}

	@RequestMapping("/joinGame")
	public String joinGame(HttpServletRequest request) {
		makeWebRequest("web-api", "8080", "WebAPI/joinGame", request);
		return "Hello from joinGame";
	}


}