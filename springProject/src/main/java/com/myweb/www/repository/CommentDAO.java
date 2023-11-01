package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;

public interface CommentDAO {

	int post(CommentVO cvo);

//	List<CommentVO> getList(int bno);

	int delete(int cno);

	int update(CommentVO cvo);

	int selectOneBnoTotalCount(int bno);

	List<CommentVO> selectListPaging(@Param("bno")int bno, @Param("pgvo")PagingVO pgvo);

	int boardCommentCount(long bno);

	int deleteAll(long bno);

}
