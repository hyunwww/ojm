package org.ojm.domain;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookWithStoreVO {
	
	private Date bdate;
	private long bkno, sno, uno;
	private String btime, bman, bname, bphone, bdepo, breq, sname;
}
