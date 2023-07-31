package org.ojm.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewAttachVO {
	private long rvino;
	private long rvno;
	private String uuid;
	private String uploadpath; 
	private String filename;
}
