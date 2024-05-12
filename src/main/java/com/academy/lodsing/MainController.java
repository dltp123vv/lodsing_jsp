package com.academy.lodsing;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.academy.lodsing.member.Member;
import com.academy.lodsing.member.MemberMapper;

@RestController
@RequestMapping("/")
public class MainController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Inject
	private MemberMapper memberMapper;
	
	@GetMapping
	public ModelAndView main() {
		
		
		return new ModelAndView("main/main");
	}
	
	@GetMapping("/member")
	public Object getMember() {
		
		List<Member> member = memberMapper.findAll();
		
		return Map.of("member", member);
	}
}
