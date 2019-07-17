package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/WorldGenerator")
public class WorldGeneratorController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from WorldGenerator:home()";
    }

	@RequestMapping("/purchaseGamePass")
	public String purchaseGamePass() {
		return "Hello from purchaseGamePass";
	}

	@RequestMapping("/joinGame")
	public String joinGame(HttpServletRequest request) {
		return "Hello from joinGame";
	}

	@RequestMapping("/updateAction")
	public String updateAction(HttpServletRequest request) {
		return "Hello from updateAction";
	}

	@RequestMapping("/getWorld")
	public String getWorld(HttpServletRequest request) {
		return "Hello from getWorld";
	}


}