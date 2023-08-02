package org.ojm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.ojm.domain.InfoVO;
import org.ojm.domain.StoreImgVO;
import org.ojm.domain.StoreVO;
import org.ojm.domain.UserVO;
import org.ojm.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/store/*")
@Log4j
@SessionAttributes("uvo")
public class StoreController {
	
	@Autowired
	StoreService service;
	
	
	@GetMapping("/register")
	public String goRegister() {
		
		return "/store/storeRegister";
	}
	//등록(사업자 기준) , test 끝
	@PostMapping(value = "/register")
	public String register(StoreVO storeInfo,
							@RequestParam("addr") String addr,
							@RequestParam("addrDet") String addrDet,
							@RequestParam("openHour") String openHour,
							@RequestParam("closeHour") String closeHour,
							@RequestParam("auth") String auth) {
		
		log.info("register.. ");
		
		
		if (storeInfo != null) {
			
			storeInfo.setSaddress(addr + " " + addrDet);
			storeInfo.setOpenHour(openHour + " ~ " + closeHour);
			if (auth.equals("user")) {
				storeInfo.setSpermmit(0);
			}else{
				storeInfo.setSpermmit(1);	// 1 >> 승인 , 0 >> 대기
			}
			log.info(storeInfo);
			
			
			
			service.storeRegister(storeInfo);
		}
		
		return "redirect:/";
	}
	
	// 매장 전체 리스트 ( test 끝 , 임시 사용 용도 )
	@GetMapping("/storeList")
	public String storeList(Model model) {
		log.info("getting storeListtttt");
		List<StoreVO> list = service.allStores();
		
		
		model.addAttribute("stores", list);
		return "/store/storeSearch";
	}
	//매장 검색( test끝 , 승인되지않은 매장은 결과에서 제외 )
	@GetMapping("/search")
	public String searchStore(@RequestParam("searchInput") String input, Model model) {
		
		
		input = "%" + input + "%"; 
		log.info("searchByKeyword >>> " + input);
		
		model.addAttribute("stores", service.searchStore(input));
		
		return "/store/storeSearch";
	}
	@GetMapping(value = "/search/filter", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreVO>> searchStore(@RequestParam("scate[]")List<String> scate,
														@RequestParam("location")String location) {
		List<StoreVO> result = null;
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		List<String> loc = new ArrayList<String>();
		if (location == null || location.equals("")) {
		}else {
			loc.add("%" + location + "%");
		}
		map.put("cateList", scate);
		map.put("location", loc);
		log.info("searchWithFilter >>> " + map);
		result = service.searchStoreWithFilter(map);
		log.info("검색결과 : " + result);
		
		
		
		
		return new ResponseEntity<List<StoreVO>>(result, HttpStatus.OK);
	}
	
	
	// 매장 상세정보 ( test 끝 )
	@GetMapping("/detail")
	public String detail(Model model, @RequestParam("sno") int sno,
							@ModelAttribute("uvo")UserVO uvo) {
		
		log.info("detail...." + sno);
		
		
		//uno을 통해 좋아요 정보 받아와서 처리해야함.
		// uno >> userinfo >> ulikestore 데이터 가공 후 현재 sno와 일치하는지 확인
		boolean isLike = false;
		InfoVO userInfo = uvo.getInfo();
		
		//이 아래에 판단하는 코드 작성 후 isLike에 대입
		
		if (userInfo.getUlikestore() != null && userInfo.getUlikestore().equals("")) {
			for (String no : userInfo.getUlikestore().split(",")) {
				if (sno == Integer.parseInt(no)) {
					isLike = true;
					break;
				}
			}
		}else {
		}
		
		
		
		
		
		model.addAttribute("isLike", isLike);
		model.addAttribute("store" , service.storeInfo(sno));
		return "/store/storeDetail";
	}
	
	
	//매장 이미지 등록 ( test 끝 )
	@PostMapping(value = "/uploadStoreImg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreImgVO>> uploadImg(MultipartFile[] uploadImgs){
		
		log.info("uploading >>" + uploadImgs.length); 
		
		List<StoreImgVO> imgList = new ArrayList<StoreImgVO>();
		
		String uploadFolder = "C:\\uploadTmp";
		File tmpFolder = new File(uploadFolder);
		log.info(tmpFolder);
		
		if (tmpFolder.exists()) { // 폴더 확인
			log.info("폴더 존재");
		}else {
			log.info("폴더 없음");
			tmpFolder.mkdirs();	//디렉토리 생성
		}
		
		for (MultipartFile file : uploadImgs) {
			log.info("Upload File Name : " + file.getOriginalFilename());
			log.info("Upload File Size : " + file.getSize());
			
			UUID uuid = UUID.randomUUID(); //랜덤 id
			
			String uploadFileName = uuid.toString() + "_" + file.getOriginalFilename();
			
			try {
				File saveFile = new File(tmpFolder, uploadFileName);
				file.transferTo(saveFile);
				StoreImgVO vo = new StoreImgVO();
				vo.setFileName(file.getOriginalFilename());
				vo.setUploadPath(tmpFolder.getAbsolutePath());
				vo.setUuid(uuid.toString());
				imgList.add(vo);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		log.info(imgList);
		
		return new ResponseEntity<List<StoreImgVO>>(imgList, HttpStatus.OK);
	}
	
	
	//매장 좋아요 적용 ( 미구현, parameter는 정상 전달 됨 )
	@GetMapping(value = "/likeStore")
	@ResponseBody
	public ResponseEntity<Boolean> likeStore(@RequestParam("sno") int sno,
											@RequestParam("uno") int uno,
											@RequestParam("current")boolean current) {
		
		log.info("storelike process");
		log.info("sno : " + sno);
		log.info("uno : " + uno);
		log.info("current : " + current);
		
		// 현재유저의 해당 매장 좋아요 여부 판단하여 true/false 전달
		
		
		
		return new ResponseEntity<Boolean>(!current, HttpStatus.OK);
	}
	
	
	//매장 등록 승인 ( test 끝 )
	@GetMapping(value = "/permission")
 	public String permitStore(@RequestParam("sno") int sno)  {
		
		
		log.info("permission");
		log.info(service.storePermit(sno));
		
		
		return "";
	}
	
	@GetMapping(value = "/myStore")
	public String goMyStore(@RequestParam("uno") int uno, Model model) {
		
		model.addAttribute("storeList", service.searchStoreByUno(uno));
		
		
		return "/store/myStore";
	}
	
	@GetMapping("/delete")
	public String goDelete(@RequestParam("sno") int sno,Model model) {
		
		model.addAttribute("store", service.storeInfo(sno));
		return "/store/storeDelete";
	}
	@PostMapping(value = "/delete", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> storeDelete(@RequestParam("sno")int sno,
												@RequestParam("pw")String pw) {
		
		log.info("delete store, pw : " + pw);
		// 유저 pw 체크 후 검증성공 시 삭제, 실패 시 실패 메세지와 함께 오류status 전송 후 script 처리
		
		return new ResponseEntity<String>("삭제되었습니다." ,HttpStatus.OK);
		
	}
	
	@GetMapping("/update")
	public String goUpdate(@RequestParam("sno")int sno, Model model) {
		
		StoreVO storeInfo = service.storeInfo(sno);
		model.addAttribute("store", storeInfo);
		String[] time = storeInfo.getOpenHour().split(" ");
		model.addAttribute("openHour", time[0]);
		model.addAttribute("closeHour", time[2]);
		return "/store/storeUpdate";
	}
	
	@PostMapping("/update")
	public String updateStore(StoreVO storeInfo,
								@RequestParam("openHour")String open,
								@RequestParam("closeHour")String close) {
		
		log.info("updating store >>> " + storeInfo);
		String time = open + " ~ " + close;
		storeInfo.setOpenHour(time);
		
		
		
		if (service.updateStore(storeInfo) > 0) {
			return "redirect:/store/myStore?uno="+storeInfo.getUno();
		}else {
			return "redrect:/";
		}
		
	}
	
	
	@PostMapping(value = "/deleteImg")
	@ResponseBody
	public ResponseEntity<String> deleteImage(@RequestBody StoreImgVO[] images){ //기존 이미지 삭제
		log.info("deleteImages... >> " + images);
		if (images == null || images.length < 1) {
			return new ResponseEntity<String>("nothing to remove", HttpStatus.OK);
		}
		for (StoreImgVO imgInfo : images) {
			File targetFile = new File(imgInfo.getUploadPath(), imgInfo.getUuid()+"_"+imgInfo.getFileName());
			if (targetFile.exists()) {
				log.info("targetFile 확인됨");
				
				if (targetFile.delete()) {
					log.info("targetFile 삭제됨");
					//서비스에서 db 정보도 삭제
					service.removeImg(imgInfo.getSino());
				}else {
					log.info("targetFile 삭제 실패");
					return new ResponseEntity<String>("remove fail", HttpStatus.INTERNAL_SERVER_ERROR);
				}
			}else {
				log.info("targetFile 없음");
				return new ResponseEntity<String>("noSuchFile", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		
		return new ResponseEntity<String>("ok", HttpStatus.OK);
	}
}
