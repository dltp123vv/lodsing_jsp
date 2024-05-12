package com.academy.lodsing.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 유저 Mapper
 * @author 이세훈
 */
@Mapper
public interface MemberMapper {

	/**
	 * 사용자 조회
	 * @param member
	 * @return
	 */
	Member findOne(
			@Param("member") Member member);
	
	//사용자 리스트 목록 조회
	List<Member> findAll();
	
	
	//사용자 회원가입
	int createMember(
			@Param("member") Member member) ;
	
	
}
