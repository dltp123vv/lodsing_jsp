package com.academy.lodsing.accommodation;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.academy.lodsing.business.Business;
import com.academy.lodsing.business.BusinessMapper;
import com.academy.lodsing.core.support.DateParse;
import com.academy.lodsing.review.Review;
import com.academy.lodsing.review.ReviewMapper;
import com.academy.lodsing.room.Room;
import com.academy.lodsing.room.RoomMapper;

@Controller
@RequestMapping("/acc")
public class AccommodationController {

	
	@Inject
	private AccommodationMapper accMapper ; 
	
	@Inject
	private BusinessMapper businessMapper ;
	
	@Inject
	private RoomMapper roomMapper ;
	
	@Inject
	private ReviewMapper reviewMapper ;
	
	
	@GetMapping("/motels")
	public String getMotel() {
		
		return "/main/motel";
	}
	
	@GetMapping("/motellist")
	public ModelAndView getMotels(String bucounty) {
		List<Accommodation> m_list = accMapper.findAll(bucounty) ;
		
		
		return new ModelAndView("/main/motel_list")
				.addObject("m_list",m_list);
	}
	
//	@GetMapping("/find")
//	public Object getAll() {
//		
//	}
	
	
	
	@GetMapping("/hotels")
	public String getHotel() {
		
		return "/main/hotel";
	}
	
//	/*@GetMapping("/hotellist")
//	public String getHotels(Model model, String bucounty) {
//		List<Accommodation> m_list = accMapper.findAll(bucounty, "호텔") ;
//		
//		model.addAttribute("m_list", m_list);
//		
//		return "/main/hotel_list";*/
				
	/**
	 * 호텔 목록들 조회
	 * @param bucounty
	 * @return
	 */
	@GetMapping("/hotellist")
	public ModelAndView getHotels(String bucounty) {
		List<Accommodation> m_list = accMapper.findHotelAll(bucounty) ;
		
		
		return new ModelAndView("/main/hotel_list")
				.addObject("m_list",m_list);
	}
	
	/**
	 * 호텔 상세보기 [ reservationController에서 추가] 
	 * @param model
	 * @param business
	 * @return
	 */
	@GetMapping("/hotelView")
	public String hotel_view(Model model, Business business) {
		
		// roomlist
		String today = DateParse.getTodayPlus(0);
		String tomorrow = DateParse.getTodayPlus(1);
		
		Business basevo = businessMapper.findOne(business);
		List<Room> roomlist = roomMapper.hotelGetRooms(basevo.getOwnid());
		
		//buname과 일치하는 rating을 받아옴
//		List<Review> reviewRateList = reviewMapper.getRating(basevo.getBuname());
		List<Review> reviewRateList = reviewMapper.getRating(basevo.getBuname()) != null ? reviewMapper.getRating(basevo.getBuname()) : Collections.emptyList();
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("buname", buname);

		//전체 게시글 조회
		List<Review> rlist = reviewMapper.getReviews(basevo.getBuname());
		model.addAttribute("list", rlist);

		model.addAttribute("bu", basevo);
		model.addAttribute("room", roomlist);
				
				return "main/hotel_view";

			}

	
	
}
