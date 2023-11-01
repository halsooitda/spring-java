package com.myweb.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/comment/*")
@RestController //rest api를 받을 수 있는 컨트롤러 
//mapping을 get,post외에 put,delete를 사용하려면 RestController을 사용해야 함
//post:생성, get:조회, put:업데이트(patch:부분수정), delete:삭제
public class CommentController {

	@Inject
	private CommentService csv;
	
	//ResponseEntity 객체 사용
	//@RequestBody : body값 추출 
	//value="mapping name", consumes : 가져오는 데이터의 형태, produces : 보내는 데이터의 형식 / 나가는 데이터 타입 : MediaType.
	//json : application/json  text : text_plain
	@PostMapping(value = "/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE) //String형태로 0,1이 보내지므로 TEXT_PLAIN_VALUE
	public ResponseEntity<String> post(@RequestBody CommentVO cvo){
						//내보낼 값의 형태
		log.info(">>>> cvo >> "+cvo);
		//DB연결
		int isOk = csv.post(cvo);
		//리턴시 response의 통신상태를 같이 리턴
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	//댓글 페이징
	@GetMapping(value = "/{bno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> spread(@PathVariable("bno")int bno, @PathVariable("page")int page){
		log.info(">>>> bno >> "+bno+" / page >> "+page);
		PagingVO pgvo = new PagingVO(page, 5);
//		List<CommentVO> list = csv.getList(bno, pgvo);
		
		return new ResponseEntity<PagingHandler>(csv.getList(bno, pgvo), HttpStatus.OK);
	}
	
	
	@DeleteMapping(value = "/{cno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("cno")int cno){
		int isOk = csv.remove(cno);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/{cno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> edit(@PathVariable("cno")int cno, @RequestBody CommentVO cvo){
		int isOk = csv.edit(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
 	
	
	
	
	
	
	
	
	
	
	
}
