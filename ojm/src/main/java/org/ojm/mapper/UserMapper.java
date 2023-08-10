package org.ojm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ojm.domain.AuthVO;
import org.ojm.domain.BoardVO;
import org.ojm.domain.Criteria;
import org.ojm.domain.InfoVO;
import org.ojm.domain.QboardVO;
import org.ojm.domain.ReviewVO;
import org.ojm.domain.UserVO;

public interface UserMapper {
	public UserVO login(@Param("id") String id, @Param("pw") String pw);
	public UserVO loginBusiness(@Param("id") String id, @Param("pw") String pw);
	public int getUno(String userid);
	
	public int regUser(UserVO uvo);
	public int regUserInfo(InfoVO ivo);
	public int regUserAuth(AuthVO avo);
	
	public int modifyUser(UserVO uvo);
	
	public int modifyUserInfo(InfoVO ivo);
	
	public String findID(@Param("username") String name,
			@Param("useremail") String email);
	
	// 메일인증
	public int newMailKey(@Param("email") String email,@Param("mail_key") String mail_key);
	public int updateMailKey(@Param("email") String email,@Param("mail_key") String mail_key);
	public int updateMailAuth(@Param("email") String email,@Param("mail_key") String mail_key);
	
	public UserVO getUserByID(String userid);
	public int idCheck(String userid);
	public int pwChange(@Param("userid") String userid,
			@Param("userpw") String userpw);
	
	
	
	// myPage
	public List<BoardVO> getListWithPaging(@Param("cri") Criteria cri,@Param("uno") int uno);
	public List<ReviewVO> getReviews(@Param("cri") Criteria cri,@Param("uno") int uno);
	public int getRvCnt(int uno);
	public List<QboardVO> getQlist(@Param("cri") Criteria cri,@Param("uno") int uno);
}
