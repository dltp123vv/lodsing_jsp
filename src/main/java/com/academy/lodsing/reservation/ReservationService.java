package com.academy.lodsing.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.academy.lodsing.core.support.DateParse;
import com.academy.lodsing.reservation.Booking;

@Service
public class ReservationService {

	@Inject
	ReservationMapper reservationMapper ;
	
	/**
	 * 예약하기
	 * @param booking
	 * @return
	 */
	public int insertBooking(Booking booking) {
		
//		int res = sqlSession.insert("reservation.reservation_booking", booking);
		int res = reservationMapper.insertBooking(booking);

		if (res == 0) {
			return 0;
		} else {
			// 날짜 차이 계산
			int dif = DateParse.dateDif(booking.getBookcheckin(), booking.getBookcheckout());

			Map map = new HashMap<String, String>();

			// 체크인 날짜 ~ 체크아웃 날짜 -1
			for (int i = 0; i < dif; i++) {
//				map.put("roomnum", booking.getRoomnum());
//				map.put("regdate", DateParse.datePlus(booking.getBookcheckin(), i));
				reservationMapper.insertReserve(booking.getRoomnum(),DateParse.datePlus(booking.getBookcheckin(), i));
			}
			return 1;
		}

	}
		
	
}
