package org.ojm.controller;

import org.ojm.domain.InfoVO;
import org.ojm.domain.UserVO;
import org.ojm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/myPage")
@SessionAttributes("uvo")	
public class MyPageController {
	
	@Setter(onMethod_ = @Autowired)
	UserService service;
	
	@GetMapping("/main")
	public String myPageMain(@ModelAttribute("uvo") UserVO vo) {
		
		log.info("myPageMain...... uno : " + vo.getUno());
		return "user/myPage/main";
	}
	@GetMapping("/tmp")
	public String myPageTmp(@ModelAttribute("uvo") UserVO vo) {
		log.info("myPageMain...... uno : " + vo.getUno());
		log.info("임시페이지");
		return "user/myPage/tmp";
	}
	
	
	@RequestMapping(value = "/modify", produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
			method = RequestMethod.POST)
	public ResponseEntity<String> modify(UserVO uvo,InfoVO ivo){
		log.info(uvo);
		log.info("modify .... uno : " + uvo.getUno());
		uvo.setInfo(ivo);
		int modifyCount = service.modifyUser(uvo);
		log.info("modifyCount : " + modifyCount);
		
		
		return modifyCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
