package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/WorldPortal")
public class WorldPortalController extends BaseController {

    @RequestMapping(value = {"","/"})
    public String home() {
        return "Hello from WorldPortal:home()";
    }

	@RequestMapping("/purchaseGamePass")
	public String purchaseGamePass(HttpServletRequest request) {
		makeWebRequest("world-generator", "8080", "WorldGenerator/purchaseGamePass", request);
		return "Hello from purchaseGamePass";
	}

	@RequestMapping("/joinGame")
	public String joinGame(HttpServletRequest request) {
		makeWebRequest("world-generator", "8080", "WorldGenerator/joinGame", request);
		return "Hello from joinGame";
	}

	@RequestMapping("/updateAction")
	public String updateAction(HttpServletRequest request) {
		makeWebRequest("world-generator", "8080", "WorldGenerator/updateAction", request);
		return "Hello from updateAction";
	}

	@RequestMapping("/getWorld")
	public String getWorld(HttpServletRequest request) {
		makeWebRequest("world-generator", "8080", "WorldGenerator/getWorld", request);
		return "Hello from getWorld";
	}
}