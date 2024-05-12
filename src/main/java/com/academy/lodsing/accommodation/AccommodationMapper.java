package com.academy.lodsing.accommodation;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.academy.lodsing.business.Business;

/**
 * 숙박정보 Mapper
 * @author 이세훈
 */
@Mapper
public interface AccommodationMapper {

	
	List<Accommodation> findAll(
			@Param("bucounty") String bucounty);
	
	
	List<Accommodation> findHotelAll(
			@Param("bucounty") String bucounty);
	
	//호텔상세 보기  [reservationController -> 추가]
	Business hotel_selectview(@Param("ownid") String ownid) ;
	
	
}
