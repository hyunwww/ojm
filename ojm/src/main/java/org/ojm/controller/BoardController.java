package org.ojm.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.ojm.domain.BoardImgVO;
import org.ojm.domain.BoardVO;
import org.ojm.domain.Criteria;
import org.ojm.domain.PageDTO;
import org.ojm.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	
	// 서비스 객체 받아오기
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@GetMapping("/list")
	public String list(Model model, Criteria cri) {
		log.info("list...");
		// 1. 서비스에서 getList() 호출
		// 2. 받아온 list 데이터를 화면에 전달
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("total", service.getTotal());
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal()));
		return "board/list";
	}
	
	@GetMapping("/register")
	public String register(Model model, Criteria cri) {
		log.info("registerPage...");
		model.addAttribute("cri", cri);
		model.addAttribute("total", service.getTotal());
		return "board/register";
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		log.info("register...");
		service.register(vo);
		rttr.addFlashAttribute("result", "ok");
		return "redirect:/board/list";
	}
	
	@GetMapping(value = "/getImgList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardImgVO>> getImgList(int bno){
		log.info("getImgList...");
		return new ResponseEntity<>(service.getImgList(bno), HttpStatus.OK);
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("bno") int bno, Model model, Criteria cri) {
		log.info("get...");
		model.addAttribute("vo", service.get(bno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", service.getTotal());
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("bno") int bno, Model model, Criteria cri) {
		log.info("modify...");
		model.addAttribute("vo", service.get(bno));
		model.addAttribute("cri", cri);
		model.addAttribute("total", service.getTotal());
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		log.info("modify...");
		if (service.modify(vo)) {
			rttr.addFlashAttribute("result", "modify");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remov(@RequestParam("bno") int bno, RedirectAttributes rttr) {
		log.info("remove...");
		List<BoardImgVO> imgList = service.getImgList(bno);
		if (service.remove(bno)) {
			deleteFiles(imgList);
			rttr.addFlashAttribute("result", "remove");
		}
		return "redirect:/board/list";
	}
	
	private void deleteFiles(List<BoardImgVO> ImgList) {
		if (ImgList == null || ImgList.size() == 0) {
			return;
		}
		log.info("delete img files...");
		log.info(ImgList);
		
		ImgList.forEach(attach ->{
			try {
				Path file = Paths.get("C:\\ojm\\" + attach.getUploadpath() + "\\" + attach.getUuid() + "_" + attach.getFilename());
				Files.deleteIfExists(file);
			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
}
