package org.ojm.controller;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.PageDTO;
import org.ojm.domain.ReportVO;
import org.ojm.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {

	@Setter(onMethod_ = @Autowired)
	private ReportService rpService;
	
	@GetMapping("/main")
	public String adminMain() {
		return "admin/main";
	}
	
	@GetMapping("/reportList")
	public String adminReportList(Model model, Criteria cri) {
		log.info("reportList...");
		model.addAttribute("reportList", rpService.getRpList(cri));
		model.addAttribute("total", rpService.getRpTotal());
		model.addAttribute("pageMaker", new PageDTO(cri, rpService.getRpTotal()));
		return "admin/reportList";
	}
	
	@GetMapping("/rpGet")
	public String get(@RequestParam("rpno") int rpno, @RequestParam(value="uno",required = false) Integer uno, Model model, Criteria cri) {
		log.info("rpGet...");
		model.addAttribute("rpvo", rpService.rpGet(rpno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", rpService.getRpTotal());
		return "admin/reportGet";
	}
	
	@GetMapping("/storeDelete")
	public String adminStoreDelete() {
		return "admin/storeDelete";
	}
	
	@GetMapping("/storeRegister")
	public String adminStoreRegister() {
		return "admin/storeRegister";
	}
	
	@GetMapping(value = "/{rpno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReportVO> getRpReplyList(@PathVariable("rpno") int rpno){
		log.info("getRpReplyList...");
		return new ResponseEntity<>(rpService.getRpReply(rpno), HttpStatus.OK);
	}
	
	@PostMapping(value = "/rpReplyRegister", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> rpReplyRegister(@RequestBody ReportVO rpvo){
		log.info("rpReplyRegister...");
		int insertCount = rpService.rpReplyRegister(rpvo);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
