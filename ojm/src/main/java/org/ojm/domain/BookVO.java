package org.ojm.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookVO {
	// 푸쉬용
	
	private long bkno, sno, uno;
	private String bdate, btime, bman, bname, bphone, bdepo, breq;
}
