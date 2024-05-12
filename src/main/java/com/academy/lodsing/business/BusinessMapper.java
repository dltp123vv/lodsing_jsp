package com.academy.lodsing.business;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 숙박정보 Mapper
 * @author 이세훈
 */
@Mapper
public interface BusinessMapper {

	/**
	 * 사업자 정보 조회
	 * @param business
	 * @return
	 */
	Business findOne(
			@Param("business") Business business);
	
	/**
	 * 사업자 등록
	 * @param business
	 */
	void createBusiness(
			@Param("business") Business business);
	
	/**
	 * 전체 사업자 리스트
	 * @return
	 */
	List<Business> getBusinesses(); 
	
	/**
	 *  사업자 등록 아이디 체크
	 * @param business
	 * @return
	 */
	Business buidcheck(
			@Param("business") Business business
			) ;

	
//	// 전체 사업자 리스트
//	public List<BusinessVO> select() {
//		List<BusinessVO> list = sqlSession.selectList("business.business_list");
//		return list;
//
//	}
//
//	// 모텔 리스트 [AccommodationMapper로 이동]
//	public List<BusinessVO> motel_select(String bucounty) {
//		List<BusinessVO> list = sqlSession.selectList("business.motel_list", bucounty);
//		return list;
//
//	}
//
//	// 호텔 리스트 [AccommodationMapper로 이동]
//	public List<BusinessVO> hotel_select(String bucounty) {
//		List<BusinessVO> list = sqlSession.selectList("business.hotel_list", bucounty);
//		return list;
//
//	}
//
//	// 펜션 리스트 [AccommodationMapper로 이동]
//	public List<BusinessVO> pension_select(String bucounty) {
//		List<BusinessVO> list = sqlSession.selectList("business.pension_list", bucounty);
//		return list;
//
//	}
//
//	public int delete(String id) {
//		int res = sqlSession.delete("business.business_delete", id);
//
//		return res;
//	}
//
//	// 사업자 등록
//	public int insert(BusinessVO vo) {
//
//		int res = sqlSession.insert("business.business_enroll", vo);
//
//		return res;
//
//	}
//	// 사업자 로그인
//
//	public BusinessVO business_select(BusinessVO vo) {
//		BusinessVO baseVO = sqlSession.selectOne("business.login_idcheck", vo);
//		return baseVO;
//	}
//
//	// 사업자 등록 아이디 체크
//	public BusinessVO buidcheck(BusinessVO vo) {
//
//		BusinessVO baseVO = sqlSession.selectOne("business.business_idcheck", vo);
//		return baseVO;
//	}
//
//	// 객실 등록 [RoomMapper로 이동]
//	public int roominsert(RoomVO vo) {
//
//		int res = sqlSession.insert("room.room_insert", vo);
//
//		return res;
//
//	}
//
//	// 전체 객실 리스트
//	public List<RoomVO> roomselect(BusinessVO vo) {
//		List<RoomVO> list = sqlSession.selectList("room.room_list",vo);
//		return list;
//
//	}
//	
//	//호텔 상세보기 룸 리스트
//			public List<RoomVO> hotel_room(BusinessVO vo){
//				List<RoomVO> list = sqlSession.selectList("room.hotel_room",vo);
//				
//				return list;
//			}
//	
//	
			
		
		

		
}
