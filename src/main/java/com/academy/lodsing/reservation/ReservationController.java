package com.academy.lodsing.reservation;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.academy.lodsing.business.Business;
import com.academy.lodsing.business.BusinessMapper;
import com.academy.lodsing.core.support.DateParse;
import com.academy.lodsing.core.support.Paging;
import com.academy.lodsing.core.support.Util;
import com.academy.lodsing.member.Member;
import com.academy.lodsing.member.MemberMapper;
import com.academy.lodsing.room.Room;
import com.academy.lodsing.room.RoomMapper;


@Controller
@RequestMapping("/reservation")
public class ReservationController {
	// Autowired를 통해 new를 통한 객체생성 없이 서블릿에서 제공해주는 클래스는
	// 자동으로 메모리할당 받을 수 있다.
	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;
	
	@Inject
	RoomMapper roomMapper;
	
	@Inject
	ReservationMapper reservationMapper ;
	
	@Inject
	BusinessMapper businessMapper ;
	
	@Inject
	MemberMapper memberMapper ;
	
	/**
	 * 예약 했던 모든 내역
	 * @param ownid
	 * @param model
	 * @param page
	 * @return
	 */
	@GetMapping("/{ownid}") 
	public String reservelist(@PathVariable String ownid, Model model, String page) { 
		int nowPage = 1;
		
		if (page != null) { 
			nowPage = Integer.parseInt(page); 
			
		}
		// 한 페이지에 표시될 게시물의 시작과 끝 변수를 계산 
		// ?page=1
		int start = (nowPage - 1) * Util.Review.BLOCKLIST + 1 ;
		int end = start + Util.Review.BLOCKLIST - 1;
	  
		// map에 시작변수와 끝 번호를 저장
		Map<Object, Object> map = new HashMap<Object,Object>(); 
		map.put("start", start); 
		map.put("end", end); 
		map.put("ownid",ownid); 
		
		List<Booking> bookingvo = roomMapper.getBookings(start, end, ownid) != null ? roomMapper.getBookings(start, end, ownid) : Collections.emptyList()  ; 
		
		// 전체게시물 수 조회
		int row_total = reservationMapper.count();
	  
		// 하단의 표기될 페이지 메뉴 생성 
		String pageMenu = Paging.getPaging(ownid,"/reservation/"+ownid, nowPage, row_total, Util.Review.BLOCKLIST, Util.Review.BLOCKPAGE);
		
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("bookingvo", bookingvo); 
		return "room/room_reserve_list"; 
		
	}
	
	/**
	 *  예약 중복 확인
	 * @param model
	 * @param business
	 * @param bookcheckin
	 * @param bookcheckout
	 * @return
	 */
	@GetMapping("/overLap")
	public String getOverLaps(Model model, Business business, String bookcheckin, String bookcheckout) {

		String today = DateParse.getTodayPlus(0);
		String tomorrow = DateParse.getTodayPlus(1);

		Business basevo = businessMapper.findOne(business);

		List<Room> roomList = roomMapper.getOverLapRooms(basevo.getOwnid(), DateParse.dateToStr(bookcheckin), DateParse.dateToStr(bookcheckout));

		model.addAttribute("bu", basevo);
		model.addAttribute("room", roomList);

		model.addAttribute("bookcheckin", bookcheckin);
		model.addAttribute("bookcheckout", bookcheckout);
		model.addAttribute("today", DateParse.strToDate(today));
		model.addAttribute("tomorrow", DateParse.strToDate(tomorrow));

		return "main/hotel_view";

	}
	
	/**
	 * 예약 내역 정보 예약하기 페이지
	 * @param bookingvo
	 * @param model
	 * @param memid
	 * @param request
	 * @return
	 */
	@GetMapping
	public String reserve(Booking bookingvo, Model model, Member member, HttpServletRequest request) {

		Member membervo = null;

		membervo = memberMapper.findOne(member);

		int night = DateParse.dateDif(bookingvo.getBookcheckin(), bookingvo.getBookcheckout()); // (checkout-checkin)
		bookingvo.setBookprice((Integer.parseInt(bookingvo.getBookprice()) * night) + "");
		bookingvo.setMemid(member.getMemid());

		HttpSession session = request.getSession();
		session.setAttribute("booking", bookingvo);
		model.addAttribute("member", membervo);

		return "reservation/reservation";
	}
	
	/**
	 * 예약하기
	 * @param booknum
	 * @param bookpayment
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/reservepro", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String reservePro(String booknum, String bookpayment, Model model, HttpServletRequest request) {
		String msg = "예약을 실패했습니다.";
		System.out.println("booknum" + booknum);
		System.out.println("bookpayment" + bookpayment);

		HttpSession session = request.getSession();

		Booking bookingvo = (Booking) session.getAttribute("booking");

		bookingvo.setBooknum(booknum);
		bookingvo.setBookpayment(bookpayment);
		bookingvo.setBookregdate(DateParse.getTodayPlus(0));
		bookingvo.setBookstatus(1);
		bookingvo.setBookcheckin(DateParse.dateToStr(bookingvo.getBookcheckin()));
		bookingvo.setBookcheckout(DateParse.dateToStr(bookingvo.getBookcheckout()));

		int result = reservationMapper.insertBooking(bookingvo);
		System.out.println(result);
		if (result != 0) {
			msg = bookingvo.getBuname() + "/" + bookingvo.getRoomname() + "에 예약하였습니다.";
			session.removeAttribute("booking");
			System.out.println(msg);
		}

		model.addAttribute("msg", msg);
		return "?msg=" + msg;
	}
	 


////	 객실 상세정보 가져오기 Room으로 변경
//	@RequestMapping("/roomdetail")
//	public String roomDetail(Model model, int roomnum) {
//
//		// 객실 정보와 사진 가져오기
//		RoomVO roomvo = reservation_dao.getRoom(roomnum);
//
//		// 선택한 객실의 정보를 가져와서 파싱 후 저장
//		String info = roomvo.getRoominfo().replace("\r\n", "<br/>");
//
//		model.addAttribute("room", roomvo);
//
//		model.addAttribute("info", info);
//
//		return "WEB-INF/views/room/room_detail.jsp";
//	}

	// 호텔 상세보기 Accommodation로변경
//	@RequestMapping("/hotel_view.do")
//	public String hotel_view(Model model, String ownid, String bookcheckin, String bookcheckout, String page) {
//
//		// roomlist
//		String today = DateParse.getTodayPlus(0);
//		String tomorrow = DateParse.getTodayPlus(1);
//
//		BusinessVO basevo = reservation_dao.hotel_selectview(ownid);
//		List<RoomVO> roomlist = reservation_dao.hotel_room(ownid);
//		String buname = basevo.getBuname();
//
//		// buname과 일치하는 rating을 받아옴
//		List<ReviewVO> reviewRateList = reservation_dao.hotel_rate_avg(buname);
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("buname", buname);
//
//		List<ReviewVO> rlist = reservation_dao.selectList(map);
//		model.addAttribute("list", rlist);
//
//		model.addAttribute("bu", basevo);
//		model.addAttribute("room", roomlist);
//		
//		return "/WEB-INF/views/main/hotel_view.jsp";
//
//	}

//	// 예약 중복 확인
//	@GetMapping("/hotel_overlap")
//	public String hotel_overlap(Model model, String ownid, String bookcheckin, String bookcheckout) {
//
//		String today = DateParse.getTodayPlus(0);
//		String tomorrow = DateParse.getTodayPlus(1);
//
//		BusinessVO basevo = reservation_dao.hotel_selectview(ownid);
//
//		List<RoomVO> roomList = reservation_dao.getOverlapRoomList(ownid,
//
//				DateParse.dateToStr(bookcheckin), DateParse.dateToStr(bookcheckout));
//
//		model.addAttribute("bu", basevo);
//		model.addAttribute("room", roomList);
//
//		model.addAttribute("bookcheckin", bookcheckin);
//		model.addAttribute("bookcheckout", bookcheckout);
//		model.addAttribute("today", DateParse.strToDate(today));
//		model.addAttribute("tomorrow", DateParse.strToDate(tomorrow));
//
//		return "/WEB-INF/views/main/hotel_view.jsp";
//
//	}

//	// 예약 내역 정보 예약하기 페이지
//	@RequestMapping("/reservation.do")
//	public String reserve(BookingVO bookingvo, Model model, String memid, HttpServletRequest request) {
//
//		MemberVO membervo = null;
//
//		membervo = reservation_dao.getMemberOne(memid);
//
//		int night = DateParse.dateDif(bookingvo.getBookcheckin(), bookingvo.getBookcheckout()); // (checkout-checkin)
//		bookingvo.setBookprice((Integer.parseInt(bookingvo.getBookprice()) * night) + "");
//		bookingvo.setMemid(memid);
//
//		HttpSession session = request.getSession();
//		session.setAttribute("booking", bookingvo);
//		model.addAttribute("member", membervo);
//
//		return "/WEB-INF/views/reservation/reservation.jsp";
//	}
//
//	// 예약하기
//	@RequestMapping(value = "reservepro.do", produces = "application/text; charset=UTF-8")
//	@ResponseBody
//	public String reservePro(String booknum, String bookpayment, Model model, HttpServletRequest request) {
//		String msg = "예약을 실패했습니다.";
//		System.out.println("booknum" + booknum);
//		System.out.println("bookpayment" + bookpayment);
//
//		HttpSession session = request.getSession();
//
//		BookingVO bookingvo = (BookingVO) session.getAttribute("booking");
//
//		bookingvo.setBooknum(booknum);
//		bookingvo.setBookpayment(bookpayment);
//		bookingvo.setBookregdate(DateParse.getTodayPlus(0));
//		bookingvo.setBookstatus(1);
//		bookingvo.setBookcheckin(DateParse.dateToStr(bookingvo.getBookcheckin()));
//		bookingvo.setBookcheckout(DateParse.dateToStr(bookingvo.getBookcheckout()));
//
//		int result = reservation_dao.insertBooking(bookingvo);
//		System.out.println(result);
//		if (result != 0) {
//			msg = bookingvo.getBuname() + "/" + bookingvo.getRoomname() + "에 예약하였습니다.";
//			session.removeAttribute("booking");
//			System.out.println(msg);
//		}
//
//		model.addAttribute("msg", msg);
//		return "?msg=" + msg;
//	}
//
//	// 내 예약 목록 가져오기
//	@GetMapping("/reservationlist")
//	public String reservationlist(Model model, HttpServletRequest request) {
//
//		HttpSession session = request.getSession();
//		Member membervo = (Member) session.getAttribute("user");
//
//		List<BookingVO> bookingVO = reservation_dao.getmemberbookinglist(membervo);
//
//		model.addAttribute("bookinglist", bookingVO);
//
//		return "WEB-INF/views/reservation/reservation_list.jsp";
//
//	}
//
//	// 예약 취소하기
//	@DeleteMapping("/{booknum}")
//	public String cancelReservation(Model model,@PathVariable String booknum) throws IOException {
//		String msg = "예약 취소를 실패했습니다.";
//		model.addAttribute("msg", msg);
//
//		try {
//			int result = reservationMapper.cancelReservation(booknum);
//			if (result != 0)
//				msg = "예약이 취소되었습니다.";
//			model.addAttribute("msg", msg);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "redirect:/reservationlist.do";
//		}
//		return "redirect:/reservationlist.do";
//	}

}
