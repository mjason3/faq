package demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@RequestMapping(value = "/addFAQ")
	public String addFAQ() {
		return "addFAQ";
	}

	@RequestMapping(value = "")
	public String admin() {
		return "admin";
	}
}
