package com.academy.lodsing.member;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Inject
	public MemberMapper memberMapper;
	
	// 회원 로그인
	@PostMapping("/login")
	@ResponseBody
	public String loginCheck(Member vo, HttpServletRequest request) {
		Member baseVO = memberMapper.findOne(vo);

		logger.info("@@@@@@@@");
		String resultStr = "";

		if (baseVO == null) {
			resultStr = "no_memid";
			return resultStr;
		}

		if (!baseVO.getMempwd().equals(vo.getMempwd())) {
			resultStr = "no_mempwd";
			return resultStr;
		}

		HttpSession session = request.getSession();
		session.setAttribute("user", baseVO);
		resultStr = "clear";
			
		logger.info("resultStr" + resultStr);
		return resultStr;
		}

		@GetMapping("/logout")
		public String logout(HttpServletRequest request) {
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			return "redirect:/";
		}
		
		// 회원 등록 폼
		@GetMapping("/form")
		public String createMemform() {
			return "member/member_enroll";
		}

		// 회원 등록
		@PostMapping("/form") 
		public String createMember(Member vo) {
			
			memberMapper.createMember(vo); 
			
			return "redirect:/login"; 
			}
		 
		
		//중복확인
		@GetMapping("/checkId")
		@ResponseBody
		public String checkId(Member vo) {
			Member baseVO = memberMapper.findOne(vo);

			String resultStr = "";
			if (baseVO == null) {
				resultStr = "no_id";
			} else {
				resultStr = "yes_id";
			}

			return resultStr;
		}
		

}
