package org.ojm.domain;

import java.util.List;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FilterVO {
	private String location, distance,reservation,delivery, categories;
	
	
}
