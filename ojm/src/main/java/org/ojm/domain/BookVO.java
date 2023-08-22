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
	private String bdate, btime, bman, bname, bphone, bdepo, breq;
}
