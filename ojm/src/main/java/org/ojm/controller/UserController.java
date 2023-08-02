package org.ojm.controller;


import javax.mail.MessagingException;

import org.ojm.domain.AuthVO;
import org.ojm.domain.InfoVO;
import org.ojm.domain.UserVO;
import org.ojm.mail.MailHandler;
import org.ojm.mail.TempKey;
import org.ojm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user")
@SessionAttributes("uvo")	
// model에 속성을 추가할 때 괄호와 키 값이 같으면 세션에 추가해주는 어노테이션
// 이 어노테이션이 붙어 있으면 model에서 해당 키값으로 찾을 때 세션에서 찾아줌
// => 안붙어있는 다른 컨트롤러에서는 세션으로 조회 불가능

// 이 경우 세션 데이터를 삭제하려면
// SessionStatus 객체인 SessionStatus status 생성하여 파라미터로 넘기고
// status.setComplete() 메소드를 통해 스프링 API 관리 세션 데이터 일괄 삭제

// 메소드에 @ModelAttribute(key) String value를 파라미터로 넘기면
// String value = (String)session.getAttribute(key) 와 유사하게 자동 바인딩 해줌
public class UserController {
	
	@Setter(onMethod_ = @Autowired)
	UserService service;
	
	@Autowired(required = false)
    JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/login")
	public void userLogin() {
		log.info("loginPage......");
	}
	@PostMapping("/login")
	public String getLogin(@RequestParam("id") String id,
							@RequestParam("pw") String pw,
							Model model,
							SessionStatus status) {
		log.info("getLogin......" + status );
		log.info("id : " + id);
		log.info("pw : " + pw);
		UserVO vo = service.login(id, pw);
		log.info(vo);
		
		if(vo!=null) {
			model.addAttribute("uvo", vo);
			/*
			 * if(vo.getAuthList().toString().c) { return "user/myPage/main"; }
			 */
			return "redirect:/user/myPage/tmp";
		}
		return "redirect:login";
	}
	@GetMapping("/register")
	public String register() {
		log.info("register......");
		return "user/register";
	}
	@GetMapping("/reg_user")
	public String userRegisterG() {
		log.info("userRegister......");
		return "user/userRegister";
	}
	@PostMapping("/regUser")
	public String userRegisterP(UserVO uvo,InfoVO ivo,AuthVO avo, Model model) {
		log.info("userRegister Post......");
		log.info(uvo);
		log.info(ivo);
		log.info(avo);
		
		if(service.regUser(uvo,ivo)>0) {
			model.addAttribute("register", "user");
		}else {
			model.addAttribute("register", "fail");
		}
		
		
		return "redirect:login";
	}
	
	@GetMapping("/reg_buisness")
	public String buisnessRegisterG() {
		log.info("buisnessRegister......");
		return "user/buisnessRegister";
	}
	
	@PostMapping("/reg_buisness")
	public String buisnessRegisterP(Model model,
			@RequestParam("userid") String userid,
			@RequestParam("userpw") String userpw,
			@RequestParam("username") String username,
			@RequestParam("userbirth") String userbirth,
			@RequestParam("userphone") String userphone,
			@RequestParam("useremail") String useremail
			) {
		log.info("buisnessRegister Post......");
		UserVO uvo = new UserVO();
		
		uvo.setUserid(userid);
		uvo.setUserpw(passwordEncoder.encode(userpw));
		uvo.setUsername(username);
		uvo.setUserphone(userphone);
		uvo.setUseremail(useremail);
		
		if(service.regUser(uvo)>0) {
			model.addAttribute("register", "buisness");
		}else {
			model.addAttribute("register", "fail");
		}
		// 가입 성공 시 특정 메세지로 일반 유저,사업자 나누고 
		// getRegister 페이지에서 성공/실패에 따라 페이지 나누면 좋을듯.
		
		
		return "redirect:login";
	}
	
	@GetMapping("/findID")
	public void findID() {
		log.info("findID......");
	}
	@PostMapping("/findIDCheck")
	public void findIDCheck(@RequestParam("useremail") String useremail,
			@RequestParam("username") String username,Model model) throws Exception {
		log.info("findIDCheck......");
		log.info("name : " + username);
		log.info("email : " + useremail);
		
		String id = service.findID(username, useremail);
		log.info("ID : " + id);
		
		if(id == null) {
			return;
		}
		
		// 메일 보내기
		String mail_key = new TempKey().getKey(10,false);	// 몇자리인지
		log.info("mail_key : " + mail_key);
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("인증메일 입니다.");
		sendMail.setText("인증번호 : " + mail_key);
        sendMail.setFrom("tmpAdmin@naver.com", "임시");
        sendMail.setTo(useremail);
        sendMail.send();
        
        service.updateMailKey(useremail, mail_key);
		
		model.addAttribute("userid",id);
		model.addAttribute("useremail",useremail);
		model.addAttribute("mail_key",mail_key);
	}
	// 인증코드 확인
	@ResponseBody
	@RequestMapping(value = "/mail_keyCheck",
			method = RequestMethod.POST)
	public ResponseEntity<String> mail_keyCheck(@RequestParam("mail_key") String mail_key,
												@RequestParam("useremail") String useremail){
		
		log.info("email : " + useremail);
		log.info("mail_key : " + mail_key);
		
		int check = service.updateMailAuth(useremail, mail_key);
		
		
		return check == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
