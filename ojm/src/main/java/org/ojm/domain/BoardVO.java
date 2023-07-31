package org.ojm.domain;


import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {
	private int bno, uno, bview, blike, breplycnt;
	private String bcate, btitle, bwriter, bcontent;
	private Date bdate, bupdatedate;
	
	// 등록할 때 BoardImgVO를 처리하도록 List 추가
	private List<BoardImgVO> imgList;
}
