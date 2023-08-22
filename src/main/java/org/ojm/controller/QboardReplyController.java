package org.ojm.controller;

import java.util.List;

import org.ojm.domain.QboardReplyVO;
import org.ojm.service.QboardReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/qreplies/*")
public class QboardReplyController {
	
	@Setter(onMethod_ = @Autowired)
	private QboardReplyService qservice;
	
	@PostMapping(value = "/qreplyregister", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> qRegister(@RequestBody QboardReplyVO qvo){
		log.info("qreply register...");
		log.info(qvo);
		int insertCount = qservice.qRegister(qvo);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{qno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<QboardReplyVO>> getQlist(@PathVariable("qno") int qno){
		log.info("qreply list...");
		return new ResponseEntity<>(qservice.getQlist(qno), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{qrno}/{qno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> qDelete(@PathVariable("qrno") int qrno, @PathVariable("qno") int qno){
		log.info("qreply delete...");
		int deleteCount = qservice.qRemove(qrno, qno);
		return deleteCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
