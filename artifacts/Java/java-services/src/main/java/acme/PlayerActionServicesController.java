package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/PlayerActionServices")
public class PlayerActionServicesController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from PlayerActionServices:home()";
    }

	@RequestMapping("/updateAction")
	public String updateAction() {
		return "Hello from updateAction";
	}


}