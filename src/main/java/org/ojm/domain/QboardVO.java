package org.ojm.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QboardVO {
	private int qno, uno, qreplycnt, qview;
	private String qtitle, qwriter, qcontent, qcate, qhide;
	private Date qdate, qupdatedate;
}
