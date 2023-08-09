package org.ojm.controller;

import java.util.List;

import org.ojm.domain.BoardImgVO;
import org.ojm.domain.Criteria;
import org.ojm.domain.PageDTO;
import org.ojm.domain.QboardVO;
import org.ojm.service.QboardService;
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
@RequestMapping("/qboard/*")
public class QbaordController {
	
	// 서비스 객체 받아오기
	@Setter(onMethod_ = @Autowired)
	private QboardService qservice;
	
	@GetMapping("/qlist")
	public String qlist(Model model, Criteria cri) {
		log.info("qlist...");
		model.addAttribute("qlist", qservice.getQlist(cri));
		model.addAttribute("total", qservice.getQtotal());
		model.addAttribute("pageMaker", new PageDTO(cri, qservice.getQtotal()));
		return "qboard/qlist";
	}
	
	@GetMapping("/qregister")
	public String qregister(Model model, Criteria cri) {
		log.info("qregisterPage...");
		model.addAttribute("cri", cri);
		model.addAttribute("total", qservice.getQtotal());
		return "qboard/qregister";
	}
	
	@PostMapping("qregister")
	public String qregister(QboardVO qvo, RedirectAttributes rttr) {
		log.info("qregister...");
		qservice.qRegister(qvo);
		rttr.addFlashAttribute("result", "ok");
		return "redirect:/qboard/qlist";
	}
	
	@GetMapping("/qget")
	public String qget(@RequestParam("qno") int qno, Model model, Criteria cri) {
		log.info("qget...");
		model.addAttribute("qvo", qservice.qGet(qno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", qservice.getQtotal());
		return "qboard/qget";
	}
	
	@GetMapping("/qmodify")
	public String qmodify(@RequestParam("qno") int qno, Model model, Criteria cri) {
		log.info("qmodifyPage...");
		model.addAttribute("qvo", qservice.qGet(qno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", qservice.getQtotal());
		return "qboard/qmodify";
	}
	
	@PostMapping("/qmodify")
	public String qmodify(QboardVO qvo, RedirectAttributes rttr) {
		log.info("qmodify...");
		if (qservice.qModify(qvo)){
			rttr.addFlashAttribute("result", "qModify");
		}
		return "redirect:/qboard/qlist";
	}
	
	@PostMapping("/qremove")
	public String qremove(@RequestParam("qno") int qno, RedirectAttributes rttr) {
		log.info("qremove...");
		if (qservice.qRemove(qno)) {
			rttr.addFlashAttribute("result", "qRemove");
		}
		return "redirect:/qboard/qlist";
	}
}
