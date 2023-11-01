package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberDAO mdao;

	@Transactional
	@Override
	public int register(MemberVO mvo) {
		int isOk = mdao.insert(mvo);
		return mdao.insertAuthInit(mvo.getEmail());
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}

	@Transactional
	@Override
	public List<MemberVO> getList() {
		return mdao.getList();
	}

	@Override
	public MemberVO getOne(String email) {
		return mdao.getOne(email);
	}

	@Override
	public int modify(MemberVO mvo) {
		return mdao.update(mvo);
	}
	@Override
	public int modifyNick(MemberVO mvo) {
		return mdao.updateNick(mvo);
	}
	
	@Transactional
	@Override
	public int remove(String email) {
		int isOk = mdao.delete(email);
		return mdao.deleteAuth(email);
	}

	
	
	
	
	
	
}
