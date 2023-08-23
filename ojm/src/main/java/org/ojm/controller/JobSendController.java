package org.ojm.controller;

import org.ojm.domain.Criteria;
import org.ojm.domain.JobSendVO;
import org.ojm.service.JobSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/jsboard/*")
public class JobSendController {
	
	@Setter(onMethod_ = @Autowired)
	private JobSendService jsservice;
	
	@GetMapping("/jsregister")
	public String jsregister(Model model, int uno) {
		log.info("jsregister...");
		
		return "jsboard/jsregister";
	}
	
	@PostMapping("/jsregister")
	public String jsregister(Model model, JobSendVO jsvo, RedirectAttributes rttr) {
		log.info("jsregister2...");
		jsservice.jsRegister(jsvo);
		rttr.addFlashAttribute("result", "submit");
		return "redirect:/jboard/jlist";
	}
}
