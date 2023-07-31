package org.ojm.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardReplyVO {
	public int brno, bno, uno;
	public String brwriter, brcontent;
	public Date brdate;
}
