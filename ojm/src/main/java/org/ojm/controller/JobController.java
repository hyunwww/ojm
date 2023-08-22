package org.ojm.controller;

import org.ojm.domain.Criteria;
import org.ojm.domain.JobVO;
import org.ojm.domain.PageDTO;
import org.ojm.service.JobService;
import org.ojm.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/jboard/*")
public class JobController {
	
	@Setter(onMethod_ = @Autowired)
	private JobService jservice;
	
	@Setter(onMethod_ = @Autowired)
	private StoreService sservice;
	
	@GetMapping("/jlist")
	public String jlist(Model model, Criteria cri) {
		log.info("jlist...");
		model.addAttribute("jlist", jservice.getJlist(cri));
		model.addAttribute("total", jservice.getJtotal());
		model.addAttribute("pageMaker", new PageDTO(cri, jservice.getJtotal()));
		return "jboard/jlist";
	}
	
	@GetMapping("/jregister")
	public String jregister(Model model, Criteria cri, JobVO jvo, int uno) {
		log.info("jregister...");
		model.addAttribute("stores", sservice.searchStoreByUno(uno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", jservice.getJtotal());
		return "jboard/jregister";
	}
	
	@PostMapping("/jregister")
	public String jregister(Model model, JobVO jvo, RedirectAttributes rttr) {
		log.info("jregister2...");
		jservice.jRegister(jvo);
		rttr.addFlashAttribute("result", "ok");
		return "redirect:/jboard/jlist";
	}
	
	@GetMapping("/jget")
	public String jget(@RequestParam("jno") int jno, Model model, Criteria cri) {
		log.info("jget...");
		model.addAttribute("jvo", jservice.jGet(jno));
		int sno = jservice.jGet(jno).getSno();
		model.addAttribute("store", sservice.storeInfo(sno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", jservice.getJtotal());
		return "jboard/jget";
	}
	
	@GetMapping("/jmodify")
	public String jmodify(@RequestParam("jno") int jno, int uno, Model model, Criteria cri) {
		log.info("jmodify...");
		model.addAttribute("stores", sservice.searchStoreByUno(uno));
		model.addAttribute("jvo", jservice.jGet(jno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", jservice.getJtotal());
		return "jboard/jmodify";
	}
	
	@PostMapping("/jmodify")
	public String jmodify(JobVO jvo, RedirectAttributes rttr) {
		log.info("jmodify2...");
		if (jservice.jModify(jvo)) {
			rttr.addFlashAttribute("result", "jmodify");
		}
		return "redirect:/jboard/jlist";
	}
	
	@PostMapping("/jremove")
	public String jremove(@RequestParam("jno") int jno, RedirectAttributes rttr) {
		log.info("jremove...");
		if (jservice.jRemove(jno)) {
			rttr.addFlashAttribute("result", "jremove");
		}
		return "redirect:/jboard/jlist";
	}
}
