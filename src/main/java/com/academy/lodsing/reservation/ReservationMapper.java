package com.academy.lodsing.reservation;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReservationMapper {
	// 객실 상세 정보 가져오기
//	Room getRoom(@Param("roomnum") int roomnum);

	
	/**
	 * 전체 예약 내역 수 조회
	 * @return
	 */
	int count() ; 
	
	/**
	 * 방 예약 하기 booking
	 * @param booking
	 * @return
	 */
	public int insertBooking(
			@Param("booking") Booking booking
			);
	
	/**
	 * 방 예약하기 reserved
	 * @param roomnum
	 * @param string
	 * @return
	 */
	public int insertReserve(
			@Param("roomnum") int roomnum,
			@Param("regdate") String string
			);
	
//	{
//		int count = sqlSession.selectOne("room.reservation_count");
//		return count;
//	}
	//roomd으로 이동
//	public List<Booking> getBookings(
//			@Param("start") int start, 
//			@Param("end") int end,
//			@Param("ownid") String ownid
//			);
//	{
//	List<BookingVO> bookingvo = sqlSession.selectList("room.reserve_list", map);
//
//	return bookingvo;
//}
	
	// 전체 
//	public int count() {
//		int count = sqlSession.selectOne("review.review_count");
//		return count;
//	}

	// 호텔 상세 보기 bussiness로 변경
//	Business hotel_selectview(@Params("ownid") String ownid) ;

	// 호텔 상세보기 룸 리스트 room으로 변경
//	List<RoomVO> hotel_room(@Param("ownid") String ownid) ;

//	// 예약된 중복 room 가져오기 roomMapper로 변경
//	public List<Room> getOverlapRoomList(String ownid, String bookcheckin, String bookcheckout) {
//		System.out.println("ownid =" + ownid);
//		System.out.println("bookcheckin : " + bookcheckin);
//		System.out.println("bookcheckout : " + bookcheckout);
//
//		Map map = new HashMap<Object, Object>();
//		map.put("ownid", ownid);
//		map.put("bookcheckin", bookcheckin);
//		map.put("bookcheckout", bookcheckout);
//		List<RoomVO> roomvo = sqlSession.selectList("reservation.reservation_overlap", map);
//		return roomvo;
//
//	}
//
//	// 예약자 member 가져오기
//	public Member getMemberOne(String memid) {
//		Member membervo = sqlSession.selectOne("reservation.reservation_getmember", memid);
//		return membervo;
//	}
//
//	// 방 예약 하기
//	public int insertBooking(Booking booking) {
//
//		int res = sqlSession.insert("reservation.reservation_booking", booking);
//
//		if (res == 0) {
//			return 0;
//		} else {
//			// 날짜 차이 계산
//			int dif = DateParse.dateDif(booking.getBookcheckin(), booking.getBookcheckout());
//
//			Map map = new HashMap<String, String>();
//
//			// 체크인 날짜 ~ 체크아웃 날짜 -1
//			for (int i = 0; i < dif; i++) {
//				map.put("roomnum", booking.getRoomnum());
//				map.put("regdate", DateParse.datePlus(booking.getBookcheckin(), i));
//				sqlSession.insert("reservation.reservation_reserved", map);
//			}
//			return 1;
//		}
//
//	}
//
//	// 예약 내역 가져오기
//	public List<Booking> getmemberbookinglist(MemberVO membervo) {
//
//		List<Booking> bookingvo = sqlSession.selectList("reservation.reservation_list", membervo);
//		return bookingvo;
//	}
//
//	// 예약 취소하기
//	public int cancelReservation(String booknum) {
//
//		int res = sqlSession.update("reservation.reservation_status_update", booknum);
//
//		if (res == 0) {
//			return 0;
//		} else { // 예약 중복 내역 삭제
//			Booking bookingvo = sqlSession.selectOne("reservation.reservation_select", booknum);
//			bookingvo.setBookcheckout(DateParse.datePlus(bookingvo.getBookcheckout(), -1));
//			int result = sqlSession.delete("reservation.reservation_cancel", bookingvo);
//			return result;
//		}
//
//	}
//
//	// 리뷰 전체 조회
//	// 전체 게시글 조회 reviewMapper로 이동
//	public List<Review> selectList(Map<String, Object> map) {
//		List<Review> list = sqlSession.selectList("review.review_list", map);
//		return list;
//	}
//
//
//
//	// 호텔 평균 점수 reviewMapper로 이동
//	public List<Review> hotel_rate_avg(String buname) {
//		List<Review> list = sqlSession.selectList("review.review_cal_avg", buname);
//		return list;
//	}

}
