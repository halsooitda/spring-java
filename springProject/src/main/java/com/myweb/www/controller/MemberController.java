package com.myweb.www.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.security.MemberVO;
import com.myweb.www.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member/**")
@Controller
public class MemberController {
	
	@Inject
	private BCryptPasswordEncoder bcEncoder;
	
	@Inject
	private MemberService msv;
	
	@GetMapping("/register")
	public void register() {} //왔던 곳으로 감.
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		log.info(">>>>> mvo >> "+mvo);
		
		mvo.setPwd(bcEncoder.encode(mvo.getPwd())); //받은 비밀번호를 암호화해서 다시 세팅
		int isOk = msv.register(mvo);
		log.info(">>>>> member register >> "+(isOk > 0? "성공" : "실패"));
		
		return "index";
	}
	//-----------------------------------------------------------------
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		//다시 로그인 유도
		log.info(">>>>> errMsg >> "+request.getAttribute("errMsg"));
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		
		return "redirect:/member/login";
	}
	//-----------------------------------------------------------------
	@GetMapping("/list")
	public void list(Model m) {
		List<MemberVO> list = msv.getList();
		m.addAttribute("list", list);
	}
	
	@GetMapping("/detail")		
	public void detail(Model m, @RequestParam("email")String email) {
		MemberVO mvo = msv.getOne(email);
		m.addAttribute("mvo", mvo);
	}
	
	//PathVariable
	//value = "/file/{uuid}" -> @PathVariable("uuid")String uuid
	//RequestParam
	///getDriver?name="name에 담긴 value" -> @RequestParam("실제 값") String 설정할 변수 이름
	
	@GetMapping("/modify")
	public void modify(Model m, @RequestParam("email")String email) {
		log.info(">>>>> modify emai; >>> "+email);
		MemberVO mvo = msv.getOne(email);
		log.info(">>>>> modify mvo >>> "+mvo);
		m.addAttribute("mvo", mvo);
	}
	
	@PostMapping("/modify")
	public String modify(MemberVO mvo, Model m, HttpServletRequest req, HttpServletResponse res) {
		
		if(mvo.getPwd().isEmpty()) { //비밀번호를 입력 안 했다면 닉네임만 바뀌도록
			int isOk = msv.modifyNick(mvo);
			m.addAttribute("isOK", isOk);
		}else {
			mvo.setPwd(bcEncoder.encode(mvo.getPwd())); //받은 비밀번호를 암호화해서 다시 세팅
			int isOk = msv.modify(mvo);			
			m.addAttribute("isOK", isOk);
		}
		logout(req, res);
		return "/member/login";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("email")String email, Model m, HttpServletRequest req, HttpServletResponse res) {
		int isDel = msv.remove(email);
		log.info(">>>>> member delete >> "+(isDel > 0? "성공" : "실패"));
		logout(req, res);
		m.addAttribute("isDel", isDel);
		return "index";
		//redirect:/member/logout
	}
	
	//로그아웃 메서드
	private void logout(HttpServletRequest req, HttpServletResponse res) {
		Authentication authentication = SecurityContextHolder
				.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(req, res, authentication);
	}
	
	@PostMapping("/logout")
	public String logout() {
		return "index";
	}
	
	
	
	
	
	
	
	
	
	
	
}