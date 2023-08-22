package org.ojm.controller;

import org.ojm.domain.GameVO;
import org.ojm.mapper.GameMapper;
import org.ojm.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/game/*")
public class GameController {

	@Autowired
	GameMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private GameService service;
	
		// 랜덤 페이지
		@GetMapping("/game1page")
		public String game1pg() {
			log.info("game1page......................");
			return "/game/game1";
		}
		@GetMapping("/game1")
		public String game1random(Model model) {
			model.addAttribute("list", service.randomgame());
			log.info("game1random....");
			return "/game/game1";
		}
		// 월드컵 페이지
		@GetMapping("/game2page")
		public String game2pg() {
			log.info("game2......................");
			return "/game/game2";
		}
}
