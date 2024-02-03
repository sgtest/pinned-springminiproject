package org.webservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

public class securitycontroller {

@GetMapping("/loginboard")
public void loginview() {
	
}
@PostMapping("/loginaction")
public String loginaction() {
	return null;
}
@GetMapping("/loginerror")
public void loginerror() {
	
}

@PostMapping("/logoutaction")
public String logoutaction() {
	return null;
}

@GetMapping("/boardjoin")
public void boardjoin() {
	
}
@PostMapping("/boardjoinaction")
public void boardjoinaction() {
	
}

}
