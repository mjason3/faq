package demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping(value = "/")
	public String home() {
		return "home";
	}

	@RequestMapping(value = "/addFAQ")
	public String addFAQ() {
		return "addFAQ";
	}

	@RequestMapping(value = "/admin")
	public String admin() {
		return "admin";
	}

	@RequestMapping(value = "/demo")
	public String demo() {
		return "demo";
	}
}
