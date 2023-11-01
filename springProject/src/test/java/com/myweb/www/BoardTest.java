package com.myweb.www;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.repository.BoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class) //junit을 실행하기 위한 runner, 클래스가 실행을 도와줌
@ContextConfiguration(classes = {com.myweb.www.config.RootConfig.class}) //해당하는 클래스를 가져오겠다.
public class BoardTest {
	
	@Inject
	private BoardDAO bdao;
	
	@Test
	public void insertBoard() {
		for(int i=0; i<300; i++) {
			BoardVO bvo = new BoardVO();
			bvo.setTitle("Test Title"+i);
			bvo.setWriter("tester");
			bvo.setContent("Test Content"+i);
			bdao.insert(bvo);
		}
	}
}
