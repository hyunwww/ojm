package org.ojm.controller;

import java.io.File;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.ojm.domain.BoardImgVO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class BoardUploadController {
	
	@GetMapping("/uploadForm")
	public String uploadForm() {
		log.info("upload form...");
		return "uploadForm...";
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		/*
		 MultipartFile의 메소드
		 
		 String getName()				- 파라미터의 이름 <input> 태그의 이름
		 String getOriginalFileName()	- 업로드되는 파일의 이름
		 boolean isEmpty()				- 파일이 존재하지 않는 경우 true
		 long getSize()					- 업로드 파일의 크기
		 byte[] getBytes()				- byte[]로 파일 데이터 변환
		 InputStream getInputStream()	- 파일 데이터와 연결된 InputStream 반환
		 transferTo(File file)			- 파일 저장
		 */
		
		String uploadFolder = "C:\\ojm";
		for(MultipartFile multipartFile : uploadFile) {
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// 파일 객체 만들어주기
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);		// 업로드
			} catch (Exception e) {
				log.error(e.getMessage());		// 에러메시지
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		log.info("upload ajax");
		return "uploadAjax";
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardImgVO>> uploadAjaxPost(MultipartFile[] uploadFile, Model model) {

		log.info("upload ajax post......");
		
		List<BoardImgVO> list = new ArrayList<BoardImgVO>();
		
		String uploadFolder = "C:\\ojm";
		
		// make folder
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path : " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		// 파일들 개별적으로 하나씩 처리하는 부분
		for(MultipartFile multipartFile : uploadFile) {
			log.info("------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
		
			BoardImgVO imgDto = new BoardImgVO();

			// UUID : 랜덤 값(중복되지 않는 고유값이기 때문에 시퀀스처럼 사용 가능)
			UUID uuid = UUID.randomUUID();
			
			String uploadFileName = uuid.toString() + "_" + multipartFile.getOriginalFilename();
			
			
			try {
				// 파일 객체 만들어주기
				File saveFile = new File(uploadPath, uploadFileName);
				
				multipartFile.transferTo(saveFile);		// 업로드
				
				// imgDto에 set해주기
				imgDto.setFilename(multipartFile.getOriginalFilename());
				imgDto.setUuid(uuid.toString());
				imgDto.setUploadpath(getFolder());
				
				// list에 imgDto add 해주기
				list.add(imgDto);
			} catch (Exception e) {
				log.error(e.getMessage());		// 에러메시지
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName) {
		log.info("download file : " + fileName);
		Resource resource = new FileSystemResource("C:\\ojm\\" + fileName);
		log.info("resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content-Disposition", "attachment; filename=" + new String(resourceOriginalName.getBytes("utf-8"), "ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String filename){
		log.info("deleteFile : " + filename);
		File file = null;
		
		try {
			file = new File("C:\\ojm\\" + URLDecoder.decode(filename, "utf-8"));
			file.delete();
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
