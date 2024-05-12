package com.academy.lodsing.room;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.academy.lodsing.business.Business;
import com.academy.lodsing.business.BusinessMapper;

@Controller
@RequestMapping("/room")
public class RoomController {

	@Autowired
	ServletContext application;
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	HttpServletRequest request;
	
	@Inject
	private RoomMapper roomMapper;
	
	@Inject
	private BusinessMapper businessMapper ;
	
	@Inject
	private RoomService roomService ;
	
	/**
	 * 사업자 모든 객실 리스트 (사업자 메인화면)
	 * @param model
	 * @param ownid
	 * @return
	 */
	@GetMapping("/{ownid}")
	public String getRooms(Model model,@PathVariable String ownid) {
		List<Room> list = roomMapper.getRooms(ownid);
		for(int i=0; i<list.size(); i++) {
			logger.info("파일이름"+list.get(i).getFilename() );
			logger.info("사업자"+list.get(i).getOwnid() );
			logger.info("룸네임"+list.get(i).getRoomname() );
		}
		model.addAttribute("m_list", list);
		return "business/business_main";
	}
	
	/**
	 * 객실 상세정보 가져오기 reservation에서
	 * @param model
	 * @param roomnum
	 * @return
	 */
	@GetMapping("/detail/{roomnum}")
	public String roomDetail(Model model, @PathVariable int roomnum) {
	
		// 객실 정보와 사진 가져오기
		Room roomvo = roomMapper.getRoom(roomnum);
	
		// 선택한 객실의 정보를 가져와서 파싱 후 저장
		String info = roomvo.getRoominfo().replace("\r\n", "<br/>");
	
		model.addAttribute("room", roomvo);
	
		model.addAttribute("info", info);
	
		return "room/room_detail";
	}
	
	@GetMapping("/detail")
	public String getDtail() {
		
		return "aa" ;
	}
	
	/**
	 * 객실 등록 폼 [businessController에서]
	 * @return
	 */
	@GetMapping("/form")
	public String insertRoomForm() {
		return "room/room_insert";
	}
	
	/**
	 * 객실 등록 [BusinessController에서]
	 * @param vo
	 * @return
	 */
	@PostMapping("/form")
	public String insertRoom(Room vo, String ownid) {
		// 사진을 업로드할 절대경로를 지정
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println("절대경로 : " + savePath);

		// 업로드할 파일의 정보
		MultipartFile photo = vo.getPhoto();
		System.out.println("::::" + photo.getOriginalFilename());
		String filename = "no_file";

		// 업로드 된 파일이 존재한다면
		if (!photo.isEmpty()) {
			// 업로드될 파일의 파일명
			filename = photo.getOriginalFilename();

			// 파일을 저장할 경로
			File saveFile = new File(savePath, filename);

			if (!saveFile.exists()) {
				saveFile.mkdirs();
			} else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);

			}

			// 업로드된 파일은 임시저장소에서 일정시간이 지나면 사라지는데,
			// 현재 내가 지정한 upload폴더까지 경로로 사라지지 않도록 파일을 복사하는 메서드
			try {
				photo.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		// vo에 파일명을 저장해서 DB로 전달
		vo.setFilename(filename);
		roomMapper.insertRoom(vo);
		return "redirect:/room/"+ownid;// list.do매핑을 호출하는 방법
	}


	/**
	 *  체크인 해아할 목록 및 체크인 한 목록
	 * @param model
	 * @param vo
	 * @return
	 */
	@GetMapping("/todayCheckin") 
	public String todayCheckin(Model model, Business vo) {
		
		Map<Object, Object> map = new HashMap<Object, Object>(); 
		
		Business businessvo = businessMapper.findOne(vo); 
		
		String buname = businessvo.getBuname(); 
		map = roomService.todayCheckin(buname, vo.getOwnid());
		model.addAttribute("nocheckin", map.get("notCheckin"));
		model.addAttribute("checkinok", map.get("checkinOk"));
		
		return "room/room_todaycheckin"; 
		
	}
	 

	/**
	 * 오늘 체크인 하기
	 * @param booknum
	 * @param business
	 * @return
	 */
	@PostMapping("/updateTodayCheckIn") 
	public String updateTodayCheckin(String booknum, Business business) {
		
		Business businessvo = businessMapper.findOne(business);
		
//		String buname = businessvo.getBuname(); 
		roomService.updateTodayCheckIn(booknum, businessvo.getOwnid(), businessvo.getBuname()); 
		
		return "redirect:/todayCheckin?ownid=" + business.getOwnid(); 
		}
	 

	/**
	 * 체크아웃 할 목록 및 체크아웃 한 목록
	 * @param model
	 * @param business
	 * @return
	 */
	@GetMapping("/todayCheckOut") 
	public String todayCheckOut(Model model, Business business) {
		Map<Object, Object> map = new HashMap<Object, Object>(); 
		Business businessvo = businessMapper.findOne(business); 
		
//		String buname = businessvo.getBuname(); 
		map = roomService.todayCheckOut(businessvo.getBuname(), businessvo.getOwnid());
		
		model.addAttribute("nocheckout", map.get("notCheckout"));
		model.addAttribute("checkoutok", map.get("checkoutOk"));
		
		return "room/room_todaycheckout"; 
		
	}
	 

	/**
	 * 체크아웃 하기
	 * @param booknum
	 * @param business
	 * @return
	 */
	@PostMapping("/updateTodayCheckOut") 
	public String updateTodayCheckOut(String booknum, Business business) {
		
		Business businessvo = businessMapper.findOne(business); 
		
		String buname = businessvo.getBuname(); 
		roomService.updateTodayCheckOut(business.getBuname(), business.getOwnid(), buname); 
		
		return "redirect:/room/todayCheckOut?ownid=" + business.getOwnid(); 
		
	}
	 

//	// 예약 했던 모든 내역 [reserrvationController로 이동]
//	
//	  @RequestMapping("reserve_list.do") public String reservelist(String ownid,
//	  Model model, String page) { int nowPage = 1;
//	  
//	  if (page != null) { nowPage = Integer.parseInt(page); }
//	  
//	  // 한 페이지에 표시될 게시물의 시작과 끝 변수를 계산 // ?page=1 int start = (nowPage - 1) *
//	  Util.Review.BLOCKLIST + 1; int end = start + Util.Review.BLOCKLIST - 1;
//	  
//	  // map에 시작변수와 끝 번호를 저장 Map<Object, Object> map = new HashMap<Object,
//	  Object>(); map.put("start", start); map.put("end", end); map.put("ownid",
//	  ownid); List<BookingVO> bookingvo = room_dao.reserve_list(map); // 전체게시물 수 조회
//	  int row_total = room_dao.getRowTotal();
//	  
//	  // 하단의 표기될 페이지 메뉴 생성 String pageMenu = Paging.getPaging(ownid,
//	  "reserve_list.do", nowPage, row_total, Util.Review.BLOCKLIST,
//	  Util.Review.BLOCKPAGE);
//	  
//	  model.addAttribute("pageMenu", pageMenu);
//	  
//	  model.addAttribute("bookingvo", bookingvo); return
//	  "/WEB-INF/views/room/room_reserve_list.jsp"; }
//	 
	
	// 전체 게시글 조회
	/*
	 * @RequestMapping("/reviewlist.do") public String seletList(Model model, String
	 * ownid) {
	 * 
	 * System.out.println("rrrrrrr");
	 * 
	 * BusinessVO basevo = room_dao.hotel_selecreview(ownid);
	 * 
	 * String buname = basevo.getBuname();
	 * 
	 * Map<String, Object> map = new HashMap<String, Object>(); map.put("buname",
	 * buname); System.out.println(map);
	 * 
	 * List<ReviewVO> relist = room_dao.selectreList(map);
	 * model.addAttribute("relist", relist); model.addAttribute("ownid", ownid);
	 * 
	 * return "/WEB-INF/views/review/review_list.jsp"; }
	 */
		
		// 댓글 작성을 위한 페이지로 전환
		/*
		 * @RequestMapping("/reply_form.do") public String replyForm(Model model, int
		 * idx, int ref, String buname, String ownid) { model.addAttribute("idx", idx);
		 * model.addAttribute("buname", buname); model.addAttribute("ref", ref);
		 * model.addAttribute("ownid", ownid); return
		 * "/WEB-INF/views/review/review_reply.jsp"; }
		 */
}