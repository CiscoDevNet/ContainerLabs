package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/GameLogicServices")
public class GameLogicServicesController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from GameLogicServices:home()";
    }

	@RequestMapping("/getWorld")
	public String getWorld() {
		callMongoDB("gameLogic");
		return "Hello from getWorld";
	}


}