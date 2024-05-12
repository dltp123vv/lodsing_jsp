package com.academy.lodsing.room;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.academy.lodsing.core.support.DateParse;
import com.academy.lodsing.reservation.Booking;

@Service
public class RoomService {

	@Inject
	private RoomMapper roomMapper ; 
	
	/**
	 * 오늘 체크인 목록 
	 * @param buname
	 * @param ownid
	 * @return
	 */
	public Map<Object, Object> todayCheckin(String buname, String ownid) {
		String bookcheckin = DateParse.getTodayPlus(0);
		Map<Object, Object> map = new HashMap<Object, Object>();

		map.put("buname", buname);
		map.put("bookcheckin", bookcheckin);
		map.put("ownid", ownid);
		
//		아직 체크인 안한 객실내역
//		List<BookingVO> notCheckin = sqlSession.selectList("room.room_notcheckin", map);
		List<Booking> notCheckin = roomMapper.getNotChekIn(bookcheckin, buname, ownid);
//		체크인 완료한 객실내역
//		List<BookingVO> checkinOk = sqlSession.selectList("room.room_checkinok", map);
		List<Booking> checkinOk = roomMapper.getCheckIn(bookcheckin, buname, ownid);

		Map<Object, Object> serviceMap = new HashMap<Object, Object>();
		serviceMap.clear();
		serviceMap.put("notCheckin", notCheckin);
		serviceMap.put("checkinOk", checkinOk);
		
		return serviceMap;
	}
	
	/**
	 *  오늘 체크인 업데이트
	 * @param booknum
	 * @param ownid
	 * @param buname
	 */
	@Transactional
	public void updateTodayCheckIn(String booknum, String ownid, String buname) {
		String bookcheckin = DateParse.getTodayPlus(0);
//			Map map = new HashMap<String, String>();

//			map.put("booknum", booknum);
//			map.put("buname", buname);
//			map.put("bookcheckin", bookcheckin);
//			map.put("ownid", ownid);
//			int res = sqlSession.update("room.room_update_todaycheckin", map);
		roomMapper.updateTodayCheckIn(booknum, buname, bookcheckin, ownid);
		
	}
	/**
	 * 오늘 체크아웃 목록 및 체크아웃 한 목록
	 * @param buname
	 * @param ownid
	 * @return
	 */
	public Map<Object, Object> todayCheckOut(String buname, String ownid) {
		String bookcheckout = DateParse.getTodayPlus(0);
		Map<Object, Object> map = new HashMap<Object, Object>();

		map.put("buname", buname);
		map.put("bookcheckout", bookcheckout);
		map.put("ownid", ownid);
//			아직 체크인 안한 객실내역
//		List<BookingVO> notCheckout = sqlSession.selectList("room.room_notcheckout", map);
		List<Booking> notCheckout = roomMapper.getNotChekOut(bookcheckout, ownid);
//			체크인 완료한 객실내역
//		List<Booking> checkoutOk = sqlSession.selectList("room.room_checkoutok", map);
		List<Booking> checkoutOk = roomMapper.getChekOut(buname, bookcheckout, ownid);

		Map<Object, Object> serviceMap = new HashMap<Object, Object>();
		serviceMap.clear();
		serviceMap.put("notCheckout", notCheckout);
		serviceMap.put("checkoutOk", checkoutOk);
		
		return serviceMap;
	}
	
	
	/**
	 * 오늘 체크아웃 목록 업데이트
	 * @param booknum
	 * @param ownid
	 * @param buname
	 * @return
	 */
	@Transactional
	public int updateTodayCheckOut(String booknum, String ownid, String buname) {
		String bookcheckout = DateParse.getTodayPlus(0);
//		Map map = new HashMap<String, String>();
//
//		map.put("booknum", booknum);
//		map.put("buname", buname);
//		map.put("bookcheckout", bookcheckout);
//		map.put("ownid", ownid);

		// 일찍 체크아웃 한 방 찾기
//		int rowcount = sqlSession.selectOne("room.room_update_todaychecout_count", map);
		int rowcount = roomMapper.todayCheckOutCount(booknum, bookcheckout);
		
		if (rowcount > 0) {
			//일찍 체크아웃 한 방 reserved에서 지우기 
			roomMapper.deleteReserve(booknum, bookcheckout);
		}

		int res = roomMapper.updateTodayCheckOut(buname, booknum, bookcheckout);

		return res;
	}
		
	
}
