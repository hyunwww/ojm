package org.ojm.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreVO {
	
	private int sno, uno, sdeli, slike, spermmit, smaxreserv;
	private double sstar;
	private String sname, saddress, wd, kd, sphone, scate,scrn,sdepo,openHour,dayOff;
	private Date sdate;	// sdate 추가_노헌_0829
	
	//menuList
	private List<MenuVO> menuList;
	//대표이미지
	private List<StoreImgVO> imgList;
	// 리뷰 목록
	private List<ReviewVO> revList;
	}
