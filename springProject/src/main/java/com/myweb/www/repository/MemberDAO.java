package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.security.AuthVO;
import com.myweb.www.security.MemberVO;

public interface MemberDAO {

	int insert(MemberVO mvo);

	int insertAuthInit(String email);

	MemberVO selectEmail(String username);

	List<AuthVO> selectAuths(String username);

	int updateLastLogin(String authEmail);

	List<MemberVO> getList();

	MemberVO getOne(String email);

	int update(MemberVO mvo);

	int delete(String email);

	int deleteAuth(String email);

	int updateNick(MemberVO mvo);


}
