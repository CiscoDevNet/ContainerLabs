package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/AuthServices")
public class AuthServicesController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from AuthServices:home()";
    }

	@RequestMapping("/login")
	public String login() {
		callMongoDB("accounts");
		return "Hello from login";
	}


}