package org.ojm.controller;

import java.util.Locale;

import org.ojm.domain.UserVO;
import org.ojm.service.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("uvo")
public class HomeController {
	
	@Autowired
	private HomeService hs;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		model.addAttribute("slist",hs.allStore());
		// 현재는 가게 리스트 전체를 보내지만 랜덤으로 몇개만 보내게 수정 예정
		
		return "mainPage";
	}
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		
		return "index";
	}
	
	
	
}
