package org.ojm.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class JobSendVO {
	private int jsno, jno, uno, sno;
	private String career, pobu, sname;
	private Date jsdate;
}
