package com.myweb.www.handler;

import java.util.List;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter //없어도 됨
@Getter
public class PagingHandler {
	
	// 1~10 / 11~20 / 21~30 / ...
	private int startPage; //화면에 보여지는 시작 페이지네이션 번호
	private int endPage; //화면에 보여지는 끝 페이지 번호
	private int realEndPage; //실제 마지막 페이지
	private boolean prev, next; //이전, 다음 존재 여부
	
	private int totalCount; //총 게시글 수
	private PagingVO pgvo;
	
	private List<CommentVO> cmtList; //댓글 페이징용
	
	//현재 페이지 값 가져오는 용도 / totalCount DB에서 조회 매개변수로 입력받기
	public PagingHandler(PagingVO pgvo, int totalCount) {
		//pgvo.qty : 한 페이지에 보이는 게시글의 수 = 10개
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		// 10, 20, 30 ...
		//1페이지부터 10페이지까지 어떤 페이지가 선택돼도 endPage는 10
		// 1, 2, 3 ... 10 => 10 / pageNo 1~10까지는 endPage가 10
		// 11, 12  ... 20 => 20 / pageNo 11~20까지는 endPage가 20 ...
		// 1 2 3 4 ... 10 / 10 나머지를 올려(ceil) 1로 만듦 *10 
		//화면에 표시되어야 하는 페이지 개수 1 2 3 4 5 6 7 8 9 10 => 10개
		this.endPage = //정수/정수 하면 나머지가 날아가므로 double로 형변환, ceil리턴값은 double이므로 int로 형변환
				(int)Math.ceil(pgvo.getPageNo() / (double)pgvo.getQty())*pgvo.getQty();
		this.startPage = endPage - 9;
		
		//전체 글수에서 / 한페이지에 표시되는 게시글수 pgvo.getQty() => 올림
		this.realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty());
		//endPage는 10, 20, 30 ... 형식으로만 구성
		//realEndPage는 실제 마지막 페이지
		if(realEndPage < endPage) {
			this.endPage = realEndPage;
		}
		
		this.prev = this.startPage > 1; // 1 -> 11 -> 21 -> ...
		this.next = this.endPage < realEndPage;
		
	}
	
	//댓글 페이징
	public PagingHandler(PagingVO pgvo, int totalCount, List<CommentVO> cmtList) {
		this(pgvo, totalCount);
		this.cmtList = cmtList;
	}
	
	
}
