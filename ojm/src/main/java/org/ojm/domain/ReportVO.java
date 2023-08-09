package org.ojm.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportVO {
	private int uno, rpno;
	private String rptitle, rpcontent, state;
}
