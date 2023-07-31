package org.ojm.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookVO {

	private long bkno, sno, uno;
	private Date bdate;
	private String btime, bman, bname, bphone, bdepo, breq;
}
