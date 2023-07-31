package org.ojm.controller;

import org.ojm.domain.MenuVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/menu/*")
public class MenuController {
	
	
	
	// 메뉴 등록( test 끝 )
	@PostMapping(value = "/add", produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
	public ResponseEntity<MenuVO> addMenu(@RequestBody MenuVO menu){
		
		log.info("addMenu! >>>>>> " + menu);
		
		
		//추가된 메뉴 반환
		return new ResponseEntity<MenuVO>(menu, HttpStatus.OK);
	}
	
}
