package org.ojm.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardImgVO {
	public int bino, bno;
	public String uuid, uploadpath, filename;
}
