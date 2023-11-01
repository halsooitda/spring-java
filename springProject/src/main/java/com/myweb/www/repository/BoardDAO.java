package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	//PagingVO pagingVO 추가
	List<BoardVO> getList(PagingVO pagingVO);

	BoardVO getDetail(long bno);

	int readCount(@Param("bno")long bno, @Param("cnt")int cnt);
	//파라미터를 두개 달고갈 수 있도록 param을 사용

	int delete(long bno);

	int update(BoardVO bvo);

	int getTotalCount(PagingVO pagingVO);

	long selectOneBno();

	int updateCommentCount();

	int updateFileCount();

//	int updateCommentCount(@Param("comment")int comment, @Param("bno")long bno);
//
//	int updateFileCount(@Param("file")int file, @Param("bno")long bno);

}
