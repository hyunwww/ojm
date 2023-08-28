package org.ojm.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportVO {
	private int rpno, uno;
	private String rpreason, rptitle, rpwriter, rpcontent, rpstate, rpreply;	// rpwriter, rpreply 추가_0823/노헌
	private Date rpdate, rpreplydate;	// rpdate 추가_0823/노헌, rpreplydate 추가_0828/노헌
}
