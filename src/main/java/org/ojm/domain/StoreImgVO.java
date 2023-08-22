package org.ojm.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreImgVO {
	private int sino,sno;
	private String uuid, uploadPath, fileName; 
}
