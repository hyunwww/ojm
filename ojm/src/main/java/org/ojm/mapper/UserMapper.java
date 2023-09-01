package org.ojm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ojm.domain.AuthVO;
import org.ojm.domain.BoardVO;
import org.ojm.domain.BookVO;
import org.ojm.domain.Criteria;
import org.ojm.domain.InfoVO;
import org.ojm.domain.JobSendVO;
import org.ojm.domain.JobVO;
import org.ojm.domain.ProfileImgVO;
import org.ojm.domain.QboardVO;
import org.ojm.domain.ReportVO;
import org.ojm.domain.ReviewVO;
import org.ojm.domain.StoreVO;
import org.ojm.domain.UserVO;
import org.ojm.domain.UsertableVO;

public interface UserMapper {
	public UserVO login(@Param("id") String id, @Param("pw") String pw);
	public UserVO loginBusiness(@Param("id") String id, @Param("pw") String pw);
	public int getUno(String userid);
	
	public int regUser(UserVO uvo);
	public int regUserInfo(InfoVO ivo);
	public int regUserAuth(AuthVO avo);
	public int regUserImg(ProfileImgVO img);
	
	public ProfileImgVO getUserImg(int uno);
	
	public int modifyUser(UserVO uvo);
	public int modifyUserInfo(InfoVO ivo);
	
	public String findID(@Param("username") String name,
			@Param("useremail") String email);
	
	public String findPw(@Param("id") String userid,
			@Param("useremail") String email);
	
	
	// 메일인증
	public int newMailKey(@Param("email") String email,@Param("mail_key") String mail_key);
	public int updateMailKey(@Param("email") String email,@Param("mail_key") String mail_key);
	public int updateMailAuth(@Param("email") String email,@Param("mail_key") String mail_key);
	
	public UserVO getUserByID(String userid);
	public int idCheck(String userid);
	public int pwChange(@Param("userid") String userid,
			@Param("userpw") String userpw);
	
	// 매장 좋아요
	public int deleteLikeStore(@Param("sno") String sno,
			@Param("uno") String uno);
	public int addLikeStore(@Param("sno") String sno,
			@Param("uno") String uno);
	
	
	// myPage
	// user
	public List<BoardVO> getListWithPaging(@Param("cri") Criteria cri,@Param("uno") int uno);
	public List<ReviewVO> getReviews(@Param("cri") Criteria cri,@Param("uno") int uno);
	public int getRvCnt(int uno);
	public List<QboardVO> getQlist(@Param("cri") Criteria cri,@Param("uno") int uno);
	public List<JobSendVO> getJobSendList(int uno);
	public List<BookVO> getBookList(int uno);
	public List<ReportVO> getReportList(@Param("cri") Criteria cri,@Param("uno") int uno);
	public int getReportTotalCount();
	
	// business
	public List<StoreVO> getStoreList(int uno);
	public List<BookVO> getBookListBusiness(int uno);
	public List<JobVO> getJobList(@Param("cri") Criteria cri,@Param("uno") int uno);
	public List<JobSendVO> getJobApplyList(int jno);
	
	// 노헌추가_0829
	public UsertableVO getUvoByUno(int uno);
	// 유빈추가_0901
	public String getUseridByUno(int uno);
	
	
}
