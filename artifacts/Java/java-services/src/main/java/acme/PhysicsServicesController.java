package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/PhysicsServices")
public class PhysicsServicesController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from PhysicsServices:home()";
    }

	@RequestMapping("/getWorld")
	public String getWorld() {
		return "Hello from getWorld";
	}


}