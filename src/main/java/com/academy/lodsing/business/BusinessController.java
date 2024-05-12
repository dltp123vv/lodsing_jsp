package com.academy.lodsing.business;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.academy.lodsing.room.RoomMapper;

@Controller
@RequestMapping("/business")
public class BusinessController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private BusinessMapper businessMapper;
	
	@Inject
	private RoomMapper roomMapper ; 
	
	@Autowired
	ServletContext application;
	
//	public HttpServletRequest request ;

	public String businessMain() {
		
		return "/business/business";
	}
	

	
	// 사업자 로그인 
	@PostMapping("/login")
	@ResponseBody
	public String BusinessloginCheck(Business vo, HttpServletRequest request) {
		logger.info("로그인") ;
		Business baseVO = businessMapper.findOne(vo);
		
		String resultStr = "";
		

		if (baseVO == null) {
			logger.info("아이디없음") ;
			resultStr = "no_ownid";
			return resultStr;
		}

		if (!baseVO.getOwnpwd().equals(vo.getOwnpwd())) {
			resultStr = "no_ownpwd";
			return resultStr;
		}
		
		if (baseVO.getApproval().equals("미승인")) {
			//resultStr = "no_approval";
			logger.info("미승인임") ;
			resultStr = "no_approval";
			return resultStr;
		}
		logger.info("아이디 : "+ baseVO.getOwnid());

		HttpSession session = request.getSession();
		session.setAttribute("business", baseVO);
		
		
		resultStr = "clear";
			
		logger.info("resultStr" + resultStr);
		return resultStr;
				
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("business");
		
		return "redirect:/";
		
	}
		
	// 사업자 등록 폼
	@GetMapping("/form")
	public String businessenrollform() {
		
		return "business/business_enroll";
		
	}
	
	// 사업자 회원가입 아이디 중복체크 폼
	@RequestMapping("/checkId")
	@ResponseBody
	public String buidcheck(Business vo) {
		Business baseVO = businessMapper.buidcheck(vo);

		String resultStr = "";
		if (baseVO == null) {
			resultStr = "no_id";
		} else {
			resultStr = "yes_id";
		}

		return resultStr;
	}

	// 사업자 등록
	@PostMapping("/form")
	public String createBusiness(Business vo) {
		
		logger.info("사업자 등록") ;
		// 사진을 업로드할 절대경로를 지정
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		
		logger.info("절대경로 : " + savePath);
		
		// 업로드할 파일의 정보
		MultipartFile photo = vo.getPhoto();
		logger.info("::::" + photo.getOriginalFilename());
		
		String filename = "no_file";

		// 업로드 된 파일이 존재한다면
		if (!photo.isEmpty()) {
			// 업로드될 파일의 파일명
			filename = photo.getOriginalFilename();

			// 파일을 저장할 경로
			File saveFile = new File(savePath, filename);
			
			if (!saveFile.exists()) {
				
				saveFile.mkdirs();
				
			}
			else {
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
			businessMapper.createBusiness(vo);
			return "redirect:/login"; // list.do매핑을 호출하는 방법
		}

		// 사업자 화면 //룸 리스트 [ roomController로 이동]
//		@RequestMapping("/business_main")
//		public String businessemain(Model model,String ownid) {
//
//			List<Room> list = roomMapper.hotel_room(ownid);
//			model.addAttribute("m_list", list);
//			return "business/business_main.jsp";
//		}
		
		// 모든 사업자 출력
		@GetMapping
		public String businesslist(Model model) {
			List<Business> list = businessMapper.getBusinesses();
			model.addAttribute("m_list", list);
			return "business/business_list.jsp";
		}
//		
//		@Autowired
//		ServletContext application;
//
//		@Autowired
//		HttpServletRequest request;
//
//		BusinessDAO business_dao;
//
//		public BusinessController(BusinessDAO business_dao) {
//			System.out.println("컨트롤러 생성됨!!");
//			this.business_dao = business_dao;
//		}
//
//		// 메인 페이지 MainController로 이동
//		@RequestMapping(value = { "/", "main.do" })
//		public String mainform() {
//
//			return "/WEB-INF/views/main/main.jsp";
//		}
//
//		// 모텔 지역 선택 AccommodatinoController로 이동
//		@RequestMapping("/motel.do")
//		public String motel() {
//
//			return "/WEB-INF/views/main/motel.jsp";
//		}
//
//		// 모텔 리스트 출력 AccommodatinoController로 이동
//		@RequestMapping("/motel_list.do")
//		public String motel_list(Model model, String bucounty) {
//			List<BusinessVO> list = business_dao.motel_select(bucounty);
//			model.addAttribute("m_list", list);
//
//			return "/WEB-INF/views/main/motel_list.jsp";
//		}
//
//		// 호텔 지역 선택 AccommodatinoController로 이동
//		@RequestMapping("/hotel.do")
//		public String hotel() {
//
//			return "/WEB-INF/views/main/hotel.jsp";
//		}
//
//		// 호텔 리스트 출력 AccommodatinoController로 이동
//		@RequestMapping("/hotel_list.do")
//		public String hotel_list(Model model, String bucounty) {
//			List<BusinessVO> list = business_dao.hotel_select(bucounty);
//			model.addAttribute("m_list", list);
//
//			return "/WEB-INF/views/main/hotel_list.jsp";
//		}
//		
//		
//
//		// 펜션 지역 선택 AccommodatinoController로 이동
//		@RequestMapping("/pension.do")
//		public String pension() {
//
//			return "/WEB-INF/views/main/pension.jsp";
//		}
//
//		// 펜션 리스트 출력 AccommodatinoController로 이동
//		@RequestMapping("/pension_list.do")
//		public String pension_list(Model model, String bucounty) {
//			List<BusinessVO> list = business_dao.pension_select(bucounty);
//			model.addAttribute("m_list", list);
//
//			return "/WEB-INF/views/main/pension_list.jsp";
//		}
//
//		// 모든 사업자 출력
//		@RequestMapping("/business_list.do")
//		public String businesslist(Model model) {
//			List<BusinessVO> list = business_dao.select();
//			model.addAttribute("m_list", list);
//			return "/WEB-INF/views/business/business_list.jsp";
//		}
//
//		// 사업자 로그인
//		@RequestMapping("/business_login.do")
//		@ResponseBody
//		public String BusinessloginCheck(BusinessVO vo, HttpServletRequest request) {
//			BusinessVO baseVO = business_dao.business_select(vo);
//
//			String resultStr = "";
//
//			
//			if (baseVO == null) {
//				
//				resultStr = String.format("[{'res':'%s'}, {'id':'%s'}]", "no_ownid", baseVO.getOwnid());
//				return resultStr; 
//			}
//
//			
//			if (!baseVO.getOwnpwd().equals(vo.getOwnpwd())) {
//				//resultStr = "no_ownpwd";
//				resultStr = String.format("[{'res':'%s'}, {'id':'%s'}]", "no_ownpwd", baseVO.getOwnid());
//				return resultStr;
//			}
//			if (baseVO.getApproval().equals("미승인")) {
//				//resultStr = "no_approval";
//				resultStr = String.format("[{'res':'%s'}, {'id':'%s'}]", "no_approval", baseVO.getOwnid());
//				return resultStr;
//			}
//
//
//			HttpSession session = request.getSession();
//			session.setAttribute("business", baseVO);
//			
//			resultStr = String.format("[{'res':'%s'}, {'id':'%s'}]", "clear", baseVO.getOwnid());
//			
//			//resultStr = "clear";
//			return resultStr; 
//		}
//
//		@RequestMapping("/business_logout.do")
//		public String logout(HttpServletRequest request) {
//			HttpSession session = request.getSession();
//			// user濡� ���옣�빐�몦 �뜲�씠�꽣瑜� �꽭�뀡�뿉�꽌 �젣嫄�
//			session.removeAttribute("business");
//			return "redirect:main.do";
//		}
//
//		// 사업자 삭제
//		@RequestMapping("/business_delete.do")
//		@ResponseBody
//		public String businessdelete(String id) {
//			System.out.println("id:" + id);
//			int res = business_dao.delete(id);
//			String result = "no";
//			if (res == 1) {
//				result = "yes";
//			}
//			return result;
//		}
//
//		// 사업자 회원가입 아이디 중복체크 폼
//		@RequestMapping("/buidcheck.do")
//		@ResponseBody
//		public String buidcheck(BusinessVO vo) {
//			BusinessVO baseVO = business_dao.buidcheck(vo);
//
//			String resultStr = "";
//			if (baseVO == null) {
//				resultStr = "no_id";
//			} else {
//				resultStr = "yes_id";
//			}
//
//			return resultStr;
//		}
//
//		// 사업자 등록 폼
//		@RequestMapping("/business_enroll_form.do")
//		public String businessenrollform() {
//			return "/WEB-INF/views/business/business_enroll.jsp";
//		}
//
//		// 사업자 등록
//		@RequestMapping("/business_enroll.do")
//		public String businessinsert(BusinessVO vo) {
//			// 사진을 업로드할 절대경로를 지정
//			String webPath = "/resources/upload/";
//			String savePath = application.getRealPath(webPath);
//			System.out.println("절대경로 : " + savePath);
//
//			// 업로드할 파일의 정보
//			MultipartFile photo = vo.getPhoto();
//			System.out.println("::::" + photo.getOriginalFilename());
//			String filename = "no_file";
//
//			// 업로드 된 파일이 존재한다면
//			if (!photo.isEmpty()) {
//				// 업로드될 파일의 파일명
//				filename = photo.getOriginalFilename();
//
//				// 파일을 저장할 경로
//				File saveFile = new File(savePath, filename);
//
//				if (!saveFile.exists()) {
//					saveFile.mkdirs();
//				} else {
//					long time = System.currentTimeMillis();
//					filename = String.format("%d_%s", time, filename);
//					saveFile = new File(savePath, filename);
//
//				}
//
//				// 업로드된 파일은 임시저장소에서 일정시간이 지나면 사라지는데,
//				// 현재 내가 지정한 upload폴더까지 경로로 사라지지 않도록 파일을 복사하는 메서드
//				try {
//					photo.transferTo(saveFile);
//				} catch (IllegalStateException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				} catch (IOException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//
//			}
//
//			// vo에 파일명을 저장해서 DB로 전달
//			vo.setFilename(filename);
//			int res = business_dao.insert(vo);
//			return "redirect:login_form.do";// list.do매핑을 호출하는 방법
//		}
//
//		// 사업자 화면
//		@RequestMapping("/business_main.do")
//		public String businessemain(Model model,BusinessVO vo) {
//
//			List<RoomVO> list = business_dao.hotel_room(vo);
//			model.addAttribute("m_list", list);
//			return "/WEB-INF/views/business/business_main.jsp";
//		}
//
//		// 객실 등록 폼 [rommController로이동]
//		@RequestMapping("/room_insert_form.do")
//		public String room_insert_form() {
//			return "/WEB-INF/views/room/room_insert.jsp";
//		}
//
//		// 객실 등록
//		@RequestMapping("/room_insert.do")
//		public String roominsert(RoomVO vo) {
//			// 사진을 업로드할 절대경로를 지정
//			String webPath = "/resources/upload/";
//			String savePath = application.getRealPath(webPath);
//			System.out.println("절대경로 : " + savePath);
//
//			// 업로드할 파일의 정보
//			MultipartFile photo = vo.getPhoto();
//			System.out.println("::::" + photo.getOriginalFilename());
//			String filename = "no_file";
//
//			// 업로드 된 파일이 존재한다면
//			if (!photo.isEmpty()) {
//				// 업로드될 파일의 파일명
//				filename = photo.getOriginalFilename();
//
//				// 파일을 저장할 경로
//				File saveFile = new File(savePath, filename);
//
//				if (!saveFile.exists()) {
//					saveFile.mkdirs();
//				} else {
//					long time = System.currentTimeMillis();
//					filename = String.format("%d_%s", time, filename);
//					saveFile = new File(savePath, filename);
//
//				}
//
//				// 업로드된 파일은 임시저장소에서 일정시간이 지나면 사라지는데,
//				// 현재 내가 지정한 upload폴더까지 경로로 사라지지 않도록 파일을 복사하는 메서드
//				try {
//					photo.transferTo(saveFile);
//				} catch (IllegalStateException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				} catch (IOException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//
//			}
//
//			// vo에 파일명을 저장해서 DB로 전달
//			vo.setFilename(filename);
//			int res = business_dao.roominsert(vo);
//			return "redirect:business_main.do";// list.do매핑을 호출하는 방법
//		}
		
		
}
