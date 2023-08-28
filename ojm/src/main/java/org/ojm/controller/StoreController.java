package org.ojm.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.ojm.domain.AuthVO;
import org.ojm.domain.BookVO;
import org.ojm.domain.FilterVO;
import org.ojm.domain.InfoVO;
import org.ojm.domain.ReportVO;
import org.ojm.domain.StoreImgVO;
import org.ojm.domain.StoreVO;
import org.ojm.domain.UserVO;
import org.ojm.security.domain.CustomUser;
import org.ojm.service.StoreService;
import org.ojm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/store/*")
@Log4j
public class StoreController {
	
	@Autowired
	private StoreService service;
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@GetMapping("/registerTest")
	public String regTest() {
		
		
		return "/store/testRegister";
	}
	@GetMapping("/registerUpdate")
	public String updateTest(@RequestParam("sno")int sno, Model model) {
		
		
		return "/store/testUpdate";
	}
	@GetMapping("/goTest")
	public String goTest(HttpSession session, HttpServletRequest request, Model model) {
		String referer = request.getHeader("referer");
		if (session.getAttribute("filterData") != null) {
			if (referer != null && referer.contains("detail")) {
				log.info("이전페이지 : detail");
				log.info("session 정보 : " + session.getAttribute("filterData"));
			}else {
				session.removeAttribute("filterData");
			}
		}else {
		}
		
		return "testPage";
		
	}
	@GetMapping("/detailTest")
	public String goTestDetail(@RequestParam("sno")int sno, Model model) {
		
		
		model.addAttribute("store", service.storeInfo(sno));
		return "/store/testDetail";
		
	}
	@GetMapping("/register")
	public String goRegister() {
		
		return "/store/storeRegister";
	}
	//등록(사업자 기준)
	@PostMapping(value = "/register")
	public String register(StoreVO storeInfo,
							@RequestParam("addr") String addr,
							@RequestParam("addrDet") String addrDet,
							@RequestParam("openHour") String openHour,
							@RequestParam("closeHour") String closeHour,
							@AuthenticationPrincipal CustomUser user) {
		
		log.info("register.. ");
		
		if (storeInfo != null) {
			
			storeInfo.setSaddress(addr + " " + addrDet);
			storeInfo.setOpenHour(openHour + " ~ " + closeHour);
			
			//user 권한 따라서 permmit 값 결정,     1 >> 승인 0 >> 대기
			if (user != null) {
				storeInfo.setUno(user.getUvo().getUno());
				for (AuthVO avo : user.getUvo().getAuthList()) {
					if (avo.getAuth().equals("ROLE_user")) {	//일반 유저
						storeInfo.setSpermmit(0);
					}else if (avo.getAuth().equals("ROLE_business")) {	//사업자
						storeInfo.setSpermmit(1);
						break;
					}
				}
			}
			
			log.info(storeInfo);
			
			
			
			service.storeRegister(storeInfo);
		}
		
		return "redirect:/";
	}
	
	// 매장 전체 리스트 ( test 끝 , 임시 사용 용도 )
	@GetMapping(value = "/storeList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreVO>> storeList(@RequestParam("point")int point) {
		log.info("getting storeListtttt" + point);
		return new ResponseEntity<List<StoreVO>>(service.allStores((point*5-4), (point*5)), HttpStatus.OK);
	}
	// top10 매장
	@GetMapping(value = "/rank", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<StoreVO>> rank(){
		return new ResponseEntity<List<StoreVO>>(service.rank(), HttpStatus.OK);
	}
	
	
	
	//매장 검색( test끝 , 승인되지않은 매장은 결과에서 제외 )
	@GetMapping("/search")
	public String searchStore(@RequestParam("searchInput") String input, Model model) {
		
		
		input = "%" + input + "%"; 
		log.info("searchByKeyword >>> " + input);
		
		model.addAttribute("stores", service.searchStore(input));
		
		return "/store/storeSearch";
	}
	
	//필터링
	@GetMapping(value = "/search/filter", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreVO>> searchStore(@RequestParam("scate[]")List<String> scate,
														@RequestParam("location")String location,
														@RequestParam("delivery[]")String delivery,
														@RequestParam("reservation[]")String reservation) {
		List<StoreVO> result = null;
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		List<String> loc = new ArrayList<String>();
		List<String> deli = new ArrayList<String>();
		List<String> reserv = new ArrayList<String>();
		if (location == null || location.equals("")) {
		}else {
			loc.add("%" + location + "%");
		}
		if (delivery == null || delivery.equals("")) {
		}else {
			deli.add(delivery);
		}
		if (reservation  == null || reservation.equals("")) {
		}else {
			reserv.add(reservation);
		}
	
		
		map.put("reservation", reserv);
		map.put("delivery", deli);
		map.put("cateList", scate);
		map.put("location", loc);
		log.info("searchWithFilter >>> " + map);
		result = service.searchStoreWithFilter(map);
		log.info("검색결과 : " + result);
		
		
		
		return new ResponseEntity<List<StoreVO>>(result, HttpStatus.OK);
	}
	
	
	// 매장 상세정보 ( test 끝 )
	@GetMapping("/detail")
	public String detail(Model model, @RequestParam("sno") int sno, Principal principal) {
		
		
		log.info("detail...." + sno);
		log.info("user : " + principal);
		
		//uno을 통해 좋아요 정보 받아와서 처리
		// uno >> userinfo >> ulikestore 데이터 가공 후 현재 sno와 일치하는지 확인
		boolean isLike = false;
		
		 
		if (principal != null) {	//로그인 정보가 있을경우에만 실행
			InfoVO userInfo = service.getUserById(principal.getName()).getInfo();
			
			//이 아래에 판단하는 코드 작성 후 isLike에 대입
			if (userInfo.getUlikestore() != null && !userInfo.getUlikestore().equals("")) {
				log.info(userInfo.getUlikestore());
				for (String no : userInfo.getUlikestore().split(",")) {
					if (sno == Integer.parseInt(no)) {
						isLike = true;
						break;
					}
				}
			}else {
			}
		}
		
		
		StoreVO svo = service.storeInfo(sno);
		if (svo == null) {
			model.addAttribute("errorCode", "noInfo");
			return "mainPage";
		}
		
		log.info("현재 매장 좋아요 여부 : " + isLike); 
		model.addAttribute("isLike", isLike);
		model.addAttribute("store" , svo);
		model.addAttribute("uvo", service.getUserById(principal.getName()));
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
	
	
	//매장 좋아요 적용 ( 테스트 미완 , parameter는 정상 전달 됨 )
	@GetMapping(value = "/likeStore", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Boolean> likeStore(@RequestParam("sno") int sno,
											@RequestParam("current")boolean current,
											Principal principal) {
		
		log.info("storelike process");
		log.info("sno : " + sno);
		log.info("user : " + principal);
		log.info("current : " + current);
		
		if (principal != null) { //유저 로그인 판단
			//유저
			UserVO uvo = service.getUserById(principal.getName());
			
			//해당 매장 고유번호 user정보에 추가 후 유저정보 수정
			if (current && uvo.getInfo().getUlikestore() != null) {//좋아요 이미 누른 경우 제거
				uvo.getInfo().setUlikestore(uvo.getInfo().getUlikestore().replace(String.valueOf(sno)+",", ""));
				
				//db 매장정보 수정
				service.storeLike(sno, -1, String.valueOf(uvo.getUno()));
			}else {//좋아요 아닌 경우 추가
				if (uvo.getInfo().getUlikestore() == null || uvo.getInfo().getUlikestore().isEmpty()) {
					uvo.getInfo().setUlikestore(""+sno+",");
				}else {
					uvo.getInfo().setUlikestore(uvo.getInfo().getUlikestore() +sno+",");
				}
				
				//db 매장정보 수정
				service.storeLike(sno, 1, String.valueOf(uvo.getUno()));
			}
			log.info(uvo.getInfo().getUlikestore());
			
			
			
			
			
			
			// 현재유저의 해당 매장 좋아요 여부 판단하여 true/false 전달
			return new ResponseEntity<Boolean>(!current, HttpStatus.OK);
		}else {	//비로그인 유저
			
			//에러 처리
			return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
		
		
		
		
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
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/delete")
	public String goDelete(@RequestParam("sno") int sno, Model model,
							@AuthenticationPrincipal CustomUser user) {
		
		if (user != null) {
			if (user.getUvo().getUno() != service.storeInfo(sno).getUno()) {	//유저 검증
				model.addAttribute("errorCode", "access");
				return "mainPage";
			}else {
				model.addAttribute("store", service.storeInfo(sno));
				return "/store/storeDelete";
			}
		}else {
			return "redirect:/";
		}
		
		
	}
	
	@PostMapping(value = "/delete", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> storeDelete(@RequestParam("sno")int sno,
												@RequestParam("pw")String pw,
												@AuthenticationPrincipal CustomUser uvo) {
		//@AuthenticationPrincipal 어노테이션 사용 시 유저정보 가져올 수 있음
		log.warn("user : " + uvo);
		
		
		log.info("delete store, pw : " + pw);
		// 유저 pw 체크 후 검증성공 시 삭제, 실패 시 실패 메세지와 함께 오류status 전송 후 script 처리
		if (encoder.matches(pw, uvo.getUvo().getUserpw())) {
			log.info("일치");
			return new ResponseEntity<String>("삭제되었습니다." ,HttpStatus.OK);
		}else {
			log.info("불일치");
			return new ResponseEntity<String>("비밀번호가 일치하지 않습니다." ,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/update")
	public String goUpdate(@RequestParam("sno")int sno, Model model,
							@AuthenticationPrincipal CustomUser user) {
		
		log.info("goUpdate!");
		if (user != null) {
			int storeUno = service.storeInfo(sno).getUno();
			if (user.getUvo().getUno() != storeUno) {	//유저 검증
				model.addAttribute("errorCode", "access");
				return "mainPage";
			}else {
				
				StoreVO storeInfo = service.storeInfo(sno);
				model.addAttribute("store", storeInfo);
				String[] time = storeInfo.getOpenHour().split(" ");
				model.addAttribute("openHour", time[0]);
				model.addAttribute("closeHour", time[2]);
				return "/store/storeUpdate";
			}
		}else {
			return "redirect:/";
		}
		
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
	
	
	//신고
	@PostMapping(value = "/report", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public ResponseEntity<String> reportSubmit(ReportVO report, @AuthenticationPrincipal CustomUser user){
		
		if(user != null) {
			report.setUno(user.getUvo().getUno());	//신고 유저 정보 입력해주기
		}
		
		
		log.info("report >>" + report);
		
		// 아래에 신고 내용 처리 하는 코드 작성
		service.reportSubmit(report);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	// 푸쉬용
	@PostMapping("/bookregister")
	public String addBook(BookVO vo, RedirectAttributes rttr, Model model) {
		log.info(vo);
		log.info(vo);
		log.info(vo.getBdate());
		//service.addBook(vo);
		log.info("addBook.......");
		rttr.addFlashAttribute("result", "ok");
		return "redirect:/store/detail?sno="+vo.getSno();
	}
	
	@PostMapping(value = "/filterData", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<FilterVO> saveSession(@RequestBody FilterVO fvo, HttpSession session){
		log.info("saveData : " + fvo);
		if (fvo == null) {
			return new ResponseEntity<FilterVO>(new FilterVO(), HttpStatus.INTERNAL_SERVER_ERROR);
		}else {
			String realDist = fvo.getDistance().split(" ")[fvo.getDistance().split(" ").length - 1].replace("km", "");
			fvo.setDistance(realDist);
			session.setAttribute("filterData", fvo);
			return new ResponseEntity<FilterVO>(fvo, HttpStatus.OK);
		}
	}
}
