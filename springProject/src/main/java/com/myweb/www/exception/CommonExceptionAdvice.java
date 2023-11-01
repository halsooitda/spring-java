package com.myweb.www.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class CommonExceptionAdvice {
	
	//500대
	@ExceptionHandler(Exception.class)
	public String except(Exception ex) {
		log.info(">>>>> exception >> "+ex.getMessage());
		return "error_page";
	}
	
	//404
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handler404(NoHandlerFoundException ex) { //404에서 사용되는 exception
		return "custom404"; //해당하는 오류가 발생하면 이 페이지로 넘어가기
	}
}