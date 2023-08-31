package org.ojm.controller;

import java.util.List;

import org.ojm.domain.MenuVO;
import org.ojm.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/menu/*")
public class MenuController {
	
	
	@Autowired
	private MenuService service;
	
	// 메뉴 등록( test 끝 )
	@PostMapping(value = "/add", produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
	public ResponseEntity<MenuVO> addMenu(@RequestBody MenuVO menu){
		
		log.info("addMenu! >>>>>> " + menu);
		
		//추가된 메뉴 반환,
		
		return new ResponseEntity<MenuVO>(menu, HttpStatus.OK);
	}
	
	// 메뉴 불러오기
	@GetMapping(value = "/{sno}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<MenuVO>> getMenuListBySno(@PathVariable("sno")int sno){
		
		return new ResponseEntity<List<MenuVO>>(service.getMenu(sno), HttpStatus.OK);
	};
	
}
