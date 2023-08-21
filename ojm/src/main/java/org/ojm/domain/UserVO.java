package org.ojm.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserVO {
	private int uno;
	private String userbirth;	// date형식으로 안넘겨줘서 임시로 string 처리
	private String userid,userpw,username,userphone,useremail;
	private InfoVO info;
	private List<AuthVO> authList;
}
