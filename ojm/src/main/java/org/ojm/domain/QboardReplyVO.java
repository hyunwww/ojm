package org.ojm.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QboardReplyVO {
	public int qrno, qno, uno;
	public String qrwriter, qrcontent;
	public Date qrdate;
}
