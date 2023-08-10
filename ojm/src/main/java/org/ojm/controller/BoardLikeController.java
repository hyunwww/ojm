package org.ojm.controller;

import org.ojm.domain.BoardLikeVO;
import org.ojm.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/like/*")
public class BoardLikeController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@PostMapping(value = "/bLikeUp", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> bLikeUp(@RequestBody BoardLikeVO lvo){
		log.info("bLikeUp...");
		int insertCount = service.bLikeUp(lvo.getBno(), lvo.getUno());
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/bLikeDown", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> bLikeDown(@RequestBody BoardLikeVO lvo){
		log.info("bLikeDown...");
		int DeleteCount = service.bLikeDown(lvo.getBno(), lvo.getUno());
		return DeleteCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
}
