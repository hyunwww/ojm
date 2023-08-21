package org.ojm.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class JobVO {
	private int jno, uno, jview;
	private String jtitle, jwriter, salary, jday, starttime, endtime, jcontent, jaddress, jsname;
	private Date jdate, jupdatedate;
}
