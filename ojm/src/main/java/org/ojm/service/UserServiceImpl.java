package org.ojm.service;

import org.ojm.domain.AuthVO;
import org.ojm.domain.InfoVO;
import org.ojm.domain.UserVO;
import org.ojm.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper mapper;
	
	@Override
	public UserVO login(String id, String pw) {
		
		System.out.println(id + pw);
		
		if(mapper.login(id,pw)==null) {	// 먼저 user로 로그인 해보고 안되면 비즈니스로 로그인
			return mapper.loginBusiness(id,pw);
		}
		
		return mapper.login(id,pw);
	}
	
	@Transactional
	@Override
	public int regUser(UserVO uvo,InfoVO ivo) {	// 일반유저
		
		if(mapper.regUser(uvo)>0) {
			mapper.regUserInfo(ivo);
			mapper.newMailKey(uvo.getUseremail(), " ");
			mapper.regUserAuth(new AuthVO(uvo.getUserid(), "ROLE_user"));
		}else {
			return -1;
		}
		return 1;
	}
	@Transactional
	@Override
	public int regUser(UserVO uvo) {	// 사업자
		if(mapper.regUser(uvo)>0) {
			mapper.regUserAuth(new AuthVO(uvo.getUserid(), "ROLE_business"));
			return 1;
		}else {
			return -1;
		}
	}
	@Transactional
	@Override
	public int modifyUser(UserVO uvo) {
		if(mapper.modifyUser(uvo)>0) {
			mapper.modifyUserInfo(uvo.getInfo());
		}else {
			return -1;
		}
		return 1;
	}
	
	@Override
	public String findID(String name, String email) {
		return mapper.findID(name, email);
	}
	
	// 메일인증
	@Override
	public int newMailKey(String email, String mail_key) { // 신규가입시
		return mapper.newMailKey(email, mail_key);
	}
	@Override
	public int updateMailKey(String email, String mail_key) { // 아이디 찾기
		return mapper.updateMailKey(email, mail_key);
	}
	@Override
	public int updateMailAuth(String email, String mail_key) { // 체크
		return mapper.updateMailAuth(email, mail_key);
	}
	
	@Override
	public int idCheck(String userid) {	// 아이디 중복체크
		return mapper.idCheck(userid);
	}
	
	@Override
	public int pwChange(String userid, String userpw) {	// 비밀번호 변경
		return mapper.pwChange(userid,userpw);
	}
	
}
