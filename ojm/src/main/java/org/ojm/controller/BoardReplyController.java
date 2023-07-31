package org.ojm.controller;

import java.util.List;

import org.ojm.domain.BoardReplyVO;
import org.ojm.service.BoardReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/replies/*")
public class BoardReplyController {
	/*
    동작에 따른 url 방법(http 전송 방식)
    1. 등록 - /replies/new - POST
    2. 조회 - /replies/:rno - GET
    3. 삭제 - /replies/:rno - DELETE
    4. 수정 - /replies/:rno - PUT or PATCH
    5. 페이지 - /replies/pages/:bno/:page - GET
     
    → REST 방식으로 설계할 땐 PK 기준으로 작성하는 것이 좋다. PK 만으로 CRUD가 가능하기 때문
    → 다만 댓글 목록은 PK 만으론 안되고 bno와 페이지 번호 정보가 필요
	 */
	
	@Setter(onMethod_ = @Autowired)
	private BoardReplyService service;
	
	/*
	// 1. 등록
	// consumes = 전달 받을 데이터 포맷
	// produces = 전달 할 데이터 포맷
	@PostMapping(value = "/new", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody BoardReplyVO vo){
		log.info("BoardReplyVO..." + vo);
		int insertCount = service.register(vo);
		log.info("Reply Insert Count : " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	*/
	
	@PostMapping(value = "replyregister", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody BoardReplyVO vo){
		log.info("reply register..." + vo);
		vo.setUno(1);
		int insertCount = service.register(vo);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	@GetMapping(value = "{bno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<BoardReplyVO>> getList(@PathVariable("bno") int bno){
		log.info("reply list...");
		return new ResponseEntity<>(service.getList(bno), HttpStatus.OK);
	}
	
}
