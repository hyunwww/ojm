package org.ojm.controller;

import java.util.List;

import org.ojm.domain.BookVO;
import org.ojm.domain.Criteria;
import org.ojm.domain.ReviewAttachVO;
import org.ojm.domain.ReviewVO;
import org.ojm.mapper.ReviewMapper;
import org.ojm.service.ReviewService;
import org.ojm.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/store/*")
@SessionAttributes("uvo")
public class ReviewController {

	@Setter(onMethod_=@Autowired)
	private ReviewService service;
	@Autowired
	private StoreService storeService;
	
	@GetMapping("/list")
	public String list() {
		log.info("list.....");
		return "store/list";
	}
	// 테스트
	@GetMapping("/testpage")
	public String testpage() {
		log.info("test..page....");
		return "store/test";
	}
	// 리뷰 작성 페이지
	@GetMapping("/addrvpage")
	public String addrvpage(ReviewVO vo, Model model, Criteria cri) {
		// 작성자, 내용, 별점점수, 이미지 업로드
		log.info("addrv......................");
		log.info("add 1 : " + vo);
		model.addAttribute("cri",cri);
		return "store/addrv";
	}
	// 리뷰 작성문
	@PostMapping("/addrv")
	public String addrv(ReviewVO vo, Model model) {
		log.info("addrv......" + vo);
		service.addrv(vo);
		storeService.updateRate((int)vo.getSno());
		return "redirect:/store/detail?sno="+vo.getSno();
	}
	// 예약 페이지
	@GetMapping("/bookpage")
	public String bookpage(BookVO vo, Model model) {
		// 작성자, 내용, 별점점수, 이미지 업로드
		log.info("bookpage......................");
		log.info("book 1 : " + vo);
		return "store/book";
	}
	/*
	// 리뷰 삭제
	@GetMapping("/deleterv")
	public String deleterv() {
		
		log.info("deleterv..............");
		return "store/deleterv";
	}
	*/
//	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public ResponseEntity<List<ReviewAttachVO>> getAttachList(long rvno){
//		log.info("getAttachList......." + rvno);
//		return new ResponseEntity<>(service.getAttachList(rvno), HttpStatus.OK);
//	}
}
