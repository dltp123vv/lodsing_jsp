package com.academy.lodsing.room;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.academy.lodsing.reservation.Booking;

/**
 * 유저 Mapper
 * @author 이세훈
 */
@Mapper
public interface RoomMapper {

	/**
	 * 사업자 메인 화면 룸 리스트 [businessController에서]
	 * @param ownid
	 * @return
	 */
	List<Room> getRooms(
			@Param("ownid") String ownid);	
	
	/**
	 * 객실 상세 정보 가져오기 [reservationCtroller에서]
	 * @param roomnum
	 * @return
	 */
	Room getRoom(
			@Param("roomnum") int roomnum
			);
	
	/**
	 * 호텔 룸 리스트 조회 [reservationController에서]
	 * @param ownid
	 * @return
	 */
	List<Room> hotelGetRooms(
			@Param("ownid") String ownid);
	
	/**
	 * 객실 등록 [business에서]
	 * @param room
	 */
	void insertRoom(@Param("room") Room room) ;

	/**
	 * 모든 예약 내역 조회 
	 * @param start
	 * @param end
	 * @param ownid
	 * @return
	 */
	public List<Booking> getBookings(
			@Param("start") int start, 
			@Param("end") int end,
			@Param("ownid") String ownid
			);
	/**
	 * 아직 체크인 안한 객실 내역
	 * @param bookcheckin
	 * @param buname
	 * @param ownid
	 * @return
	 */
	public List<Booking> getNotChekIn(
			@Param("bookcheckin") String bookcheckin ,
			@Param("buname") String buname ,
			@Param("ownid") String ownid 
			);
	
	/**
	 * 오늘 체크인 한 갤실 내역
	 * @param bookcheckin
	 * @param buname
	 * @param ownid
	 * @return
	 */
	public List<Booking> getCheckIn(
			@Param("bookcheckin") String bookcheckin ,
			@Param("buname") String buname ,
			@Param("ownid") String ownid 
			);
	
	/**
	 * 오늘 체크인 하기
	 * @param booknum
	 * @param buname
	 * @param bookcheckin
	 * @param ownid
	 * @return
	 */
	public int updateTodayCheckIn(
			@Param("booknum") String booknum,
			@Param("buname") String buname,
			@Param("bookcheckin") String bookcheckin,
			@Param("ownid") String ownid
			);
	/**
	 * 아직 체크아웃 안한 객실 내역
	 * @param bookcheckin
	 * @param buname
	 * @param ownid
	 * @return
	 */
	public List<Booking> getNotChekOut(
			@Param("bookcheckout") String bookcheckout ,
			@Param("ownid") String ownid 
			);
	
	/**
	 * 오늘 체크 아웃 한 갤실 내역
	 * @param bookcheckin
	 * @param buname
	 * @param ownid
	 * @return
	 */
	public List<Booking> getChekOut(
			@Param("buname") String buname ,
			@Param("bookcheckout") String bookcheckout ,
			@Param("ownid") String ownid 
			);
	
	/**
	 *  일찍 체크아웃 한 방 찾기
	 * @param booknum
	 * @param bookcheckout
	 * @return
	 */
	public int todayCheckOutCount(
			@Param("booknum") String booknum,
			@Param("bookcheckout") String bookcheckout
			
			);
	/**
	 * 일찍 체크아웃 한 방 reserved에서 지우기 
	 * @param booknum
	 * @param bookcheckout
	 */
	public void deleteReserve(
			@Param("booknum") String booknum,
			@Param("bookcheckout") String bookcheckout
			);
	
	/**
	 * 오늘 체크아웃 하기
	 * @param booknum
	 * @param buname
	 * @param bookcheckin
	 * @param ownid
	 * @return
	 */
	public int updateTodayCheckOut(
			@Param("buname") String buname,
			@Param("booknum") String booknum,
			@Param("bookcheckin") String bookcheckin
			);
	
	/**
	 * 예약된 중복 room 가져오기 roomMapper에서
	 * @param ownid
	 * @param bookcheckin
	 * @param bookcheckout
	 * @return
	 */
	public List<Room> getOverLapRooms(
			@Param("ownid") String ownid, 
			@Param("bookcheckin") String bookcheckin, 
			@Param("bookcheckout") String bookcheckout
			) ;

//	{
//	List<BookingVO> bookingvo = sqlSession.selectList("room.reserve_list", map);
//
//	return bookingvo;
//}
//	// 오늘 체크인 목록 및 체크인하기
//		public Map<Object, Object> todayCheckin(String buname, String ownid) {
//			String bookcheckin = DateParse.getTodayPlus(0);
//			Map<Object, Object> map = new HashMap<Object, Object>();
//
//			map.put("buname", buname);
//			map.put("bookcheckin", bookcheckin);
//			map.put("ownid", ownid);
////			아직 체크인 안한 객실내역
//			List<BookingVO> notCheckin = sqlSession.selectList("room.room_notcheckin", map);
////			체크인 완료한 객실내역
//			List<BookingVO> checkinOk = sqlSession.selectList("room.room_checkinok", map);
//
//			Map<Object, Object> serviceMap = new HashMap<Object, Object>();
//			serviceMap.clear();
//			serviceMap.put("notCheckin", notCheckin);
//			serviceMap.put("checkinOk", checkinOk);
//			return serviceMap;
//		}
//
//		// 사업자 ownid로 buname 가져오기 [제거]
//		public BusinessVO selectbusiness(String ownid) {
//
//			BusinessVO vo = sqlSession.selectOne("business.hotel_view", ownid);
//			return vo;
//		}
//
//		// 오늘 체크인 목록 업데이트
//		public int updatetodaycheckin(String booknum, String ownid, String buname) {
//			String bookcheckin = DateParse.getTodayPlus(0);
//			Map map = new HashMap<String, String>();
//
//			map.put("booknum", booknum);
//			map.put("buname", buname);
//			map.put("bookcheckin", bookcheckin);
//			map.put("ownid", ownid);
//			int res = sqlSession.update("room.room_update_todaycheckin", map);
//
//			return res;
//		}
//
//		// 오늘 체크아웃 목록 및 체크아웃하기
//		public Map<Object, Object> todayCheckout(String buname, String ownid) {
//			String bookcheckout = DateParse.getTodayPlus(0);
//			Map<Object, Object> map = new HashMap<Object, Object>();
//
//			map.put("buname", buname);
//			map.put("bookcheckout", bookcheckout);
//			map.put("ownid", ownid);
////				아직 체크인 안한 객실내역
//			List<BookingVO> notCheckout = sqlSession.selectList("room.room_notcheckout", map);
////				체크인 완료한 객실내역
//			List<BookingVO> checkoutOk = sqlSession.selectList("room.room_checkoutok", map);
//
//			Map<Object, Object> serviceMap = new HashMap<Object, Object>();
//			serviceMap.clear();
//			serviceMap.put("notCheckout", notCheckout);
//			serviceMap.put("checkoutOk", checkoutOk);
//			return serviceMap;
//		}
//
//		// 오늘 체크아웃 목록 업데이트
//		public int updatetodaycheckout(String booknum, String ownid, String buname) {
//			String bookcheckout = DateParse.getTodayPlus(0);
//			Map map = new HashMap<String, String>();
//
//			map.put("booknum", booknum);
//			map.put("buname", buname);
//			map.put("bookcheckout", bookcheckout);
//			map.put("ownid", ownid);
//
//			int rowcount = sqlSession.selectOne("room.room_update_todaychecout_count", map);
//			if (rowcount > 0) {
//				int delete = sqlSession.delete("room.room_book_delete", map);
//			}
//
//			int res = sqlSession.update("room.room_update_todaycheckout", map);
//
//			return res;
//		}
//
//		public List<BookingVO> reserve_list(Map<Object, Object> map) {
//			List<BookingVO> bookingvo = sqlSession.selectList("room.reserve_list", map);
//
//			return bookingvo;
//		}
//
//		// 전체 게시물 수 조회
//		public int getRowTotal() {
//			int count = sqlSession.selectOne("room.reservation_count");
//			return count;
//		}
//
//		// 호텔 상세 보기
//		public BusinessVO hotel_selecreview(String ownid) {
//			BusinessVO basevo = sqlSession.selectOne("business.hotel_view", ownid);
//			return basevo;
//		}
//
//		// 전체 게시글 조회
//		public List<ReviewVO> selectreList(Map<String, Object> map) {
//			List<ReviewVO> relist = sqlSession.selectList("room.review_relist", map);
//
//			return relist;
//		}
	

	
}
