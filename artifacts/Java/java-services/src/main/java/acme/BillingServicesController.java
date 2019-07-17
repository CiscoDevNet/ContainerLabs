package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/BillingServices")
public class BillingServicesController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from BillingServices:home()";
    }

	@RequestMapping("/purchaseGamePass")
	public String purchaseGamePass() {
		return "Hello from purchaseGamePass";
	}


}