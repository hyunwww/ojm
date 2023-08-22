package org.ojm.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewVO {

	private long rvno, sno, uno, rvlike;
	private double rvstar;
	private String rvcontent;
	private Date rvdate;
	
	private List<ReviewAttachVO> attachlist;
}
