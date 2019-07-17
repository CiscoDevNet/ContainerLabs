package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/GameCaching")
public class GameCachingController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from GameCaching:home()";
    }

	@RequestMapping("/joinGame")
	public String joinGame() {
		return "Hello from joinGame";
	}

	@RequestMapping("/updateAction")
	public String updateAction() {
		return "Hello from updateAction";
	}

	@RequestMapping("/getWorld")
	public String getWorld() {
		return "Hello from getWorld";
	}


}