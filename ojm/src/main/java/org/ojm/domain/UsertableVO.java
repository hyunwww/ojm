package org.ojm.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UsertableVO {
	private int uno;
	private String userid, userpw, username, userphone, useremail, auth;
	private Date userbirth;
}
