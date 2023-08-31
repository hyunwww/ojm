package org.ojm.controller;

import java.security.Principal;

import org.ojm.domain.Criteria;
import org.ojm.domain.InfoVO;
import org.ojm.domain.PageDTO;
import org.ojm.domain.UserVO;
import org.ojm.service.BoardService;
import org.ojm.service.JobService;
import org.ojm.service.QboardService;
import org.ojm.service.ReportService;
import org.ojm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/myPage")
@SessionAttributes({"uvo","uno"})	
public class MyPageController {
	
	@Setter(onMethod_ = @Autowired)
	UserService service;
	@Setter(onMethod_ = @Autowired)
	BoardService bs;
	@Setter(onMethod_ = @Autowired)
	QboardService qs;
	@Setter(onMethod_ = @Autowired)
	JobService js;
	@Setter(onMethod_ = @Autowired)
	ReportService rs;
	
	// 일반유저
	@GetMapping("/main")
	public String myPageMain(Principal pr,Model model) {
		log.info("myPageMain...... id : " + pr.getName());
		
		UserVO user = service.getUser(pr.getName());
		log.info(user);
		
		model.addAttribute("uno", user.getUno());
		model.addAttribute("uvo", user);
		model.addAttribute("imgRoot", service.getUserImg(user.getUno()));
		return "user/myPage/main";
	}
	@GetMapping("/mainModify")
	public String myPageMainModify(Principal pr,Model model) {
		log.info("myPageMain...... id : " + pr.getName());
		
		UserVO user = service.getUser(pr.getName());
		log.info(user);
		
		model.addAttribute("uno", user.getUno());
		model.addAttribute("uvo", user);
		model.addAttribute("imgRoot", service.getUserImg(user.getUno()));
		return "user/myPage/mainModify";
	}
	@GetMapping("/board")
	public String myPageBoard(Model model,Criteria cri, @ModelAttribute("uno") int uno) {
		log.info("myPageBoard...... ");
		
		model.addAttribute("list", service.getList(cri, uno));
		model.addAttribute("total", bs.getTotal());
		model.addAttribute("pageMaker", new PageDTO(cri, bs.getTotal()));
		return "user/myPage/board";
	}
	@GetMapping("/book")
	public String myPageBook(Principal pr,Model model) {
		log.info("myPageBook...... ");
		log.info(service.getBookList(service.getUno(pr.getName())));
		model.addAttribute("blist", service.getBookList(service.getUno(pr.getName())));
		return "user/myPage/book";
	}
	@GetMapping("/jboard")
	public String myPageJboard(Principal pr,Model model) {
		log.info("myPageJboard...... ");
		model.addAttribute("jlist", service.getJobSendList(service.getUno(pr.getName())));
		
		return "user/myPage/jboard";
	}
	@GetMapping("/qboard")
	public String myPageQboard(Model model,Criteria cri, @ModelAttribute("uno") int uno) {
		log.info("myPageQboard...... ");
		
		model.addAttribute("qlist", service.getQlist(cri,uno));
		model.addAttribute("total", qs.getQtotal());
		model.addAttribute("pageMaker", new PageDTO(cri, qs.getQtotal()));
		return "user/myPage/qboard";
	}
	@GetMapping("/review")
	public String myPageReview(Model model,Criteria cri,@ModelAttribute("uno") int uno) {
		log.info("myPageReview...... uno : " + uno);
		cri.setAmount(3);
		model.addAttribute("revList",service.getReviews(cri,uno));
		model.addAttribute("total", service.getRvCnt(uno));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getRvCnt(uno)));
		return "user/myPage/review";
	}
	@GetMapping("/report")
	public String myPageReport(Model model,Criteria cri,@ModelAttribute("uno") int uno) {
		log.info("myPageReport...");
		
		model.addAttribute("reportList", service.getReportList(cri,uno));
		model.addAttribute("total", service.getReportTotalCount());
		model.addAttribute("pageMaker", new PageDTO(cri, service.getReportTotalCount()));
		
		return "user/myPage/report";
	}
	@RequestMapping(value = "/modify", produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
			method = RequestMethod.POST)
	public ResponseEntity<String> modify(UserVO uvo,InfoVO ivo){
		log.info(uvo);
		log.info("modify .... uno : " + uvo.getUno());
		uvo.setInfo(ivo);
		int modifyCount = service.modifyUser(uvo);
		log.info("modifyCount : " + modifyCount);
		
		
		return modifyCount == 1 ? new ResponseEntity<>("회원정보를 수정했습니다.", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@RequestMapping(value = "/b/modify", produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
			method = RequestMethod.POST)
	public ResponseEntity<String> b_modify(UserVO uvo){
		log.info(uvo);
		log.info("modify .... uno : " + uvo.getUno());
		int modifyCount = service.modifyUser(uvo);
		log.info("modifyCount : " + modifyCount);
		
		
		return modifyCount == 1 ? new ResponseEntity<>("회원정보를 수정했습니다.", HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
	// 사업자
	@GetMapping("/b/main")
	public String b_main(Principal pr,Model model) {
		log.info("myPageBmain...... id : " + pr.getName());
		
		UserVO user = service.getUser(pr.getName());
		log.info(user);
		
		model.addAttribute("uvo", user);
		
		return "user/myPage/b/main";
	}
	@GetMapping("/b/store")
	public String b_store(Principal pr,Model model) {
		log.info("myPageBstore......id : " + pr.getName());
		
		model.addAttribute("slist", service.getStoreList(service.getUno(pr.getName())));
		
		return "user/myPage/b/store";
	}
	@GetMapping("/b/jboard")
	public String b_jboard(Principal pr,Model model,Criteria cri) {
		log.info("myPageBjboard......");
		
		model.addAttribute("jlist", js.getJlist(cri));
		model.addAttribute("total", js.getJtotal());
		model.addAttribute("pageMaker", new PageDTO(cri, js.getJtotal()));
		return "user/myPage/b/jboard";
	}
	@GetMapping("/b/book")
	public String b_Book(Principal pr,Model model) {
		log.info("myPageBBook...... ");
		model.addAttribute("blist", service.getBookListBusiness(service.getUno(pr.getName())));
		return "user/myPage/b/book";
	}
}