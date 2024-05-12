package com.academy.lodsing.reservation;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Booking {
	/**
	 * 예약 번호
	 */
	private String booknum ;
	/**
	 * 예약자
	 */
	private String memid ;
	/**
	 * 
	 */
	private String buname ;
	/**
	 * 
	 */
	private String roomname ;
	/**
	 * 
	 */
	private String bookcheckin ;
	/**
	 * 
	 */
	private String bookcheckout ;
	/**
	 * 
	 */
	private String bookpayment ;
	/**
	 * 
	 */
	private String bookprice ;
	/**
	 * 
	 */
	private String bookregdate ;
	/**
	 * 
	 */
	private String filename ;
	/**
	 * 
	 */
	private String memname ;
	/**
	 * 
	 */
	private String memtel ;
	/**
	 * 
	 */
	private int roomnum ;
	/**
	 * 
	 */
	private int bookstatus ;
	/**
	 * 
	 */
	private int revNum ;
	/**
	 * 
	 */
	private MultipartFile photo;

//	public int getRevNum() {
//		return revNum;
//	}
//
//	public void setRevNum(int revNum) {
//		this.revNum = revNum;
//	}
//
//	public String getMemname() {
//		return memname;
//	}
//
//	public void setMemname(String memname) {
//		this.memname = memname;
//	}
//
//	public String getMemtel() {
//		return memtel;
//	}
//
//	public void setMemtel(String memtel) {
//		this.memtel = memtel;
//	}
//
//
//	public String getFilename() {
//		return filename;
//	}
//
//	public void setFilename(String filename) {
//		this.filename = filename;
//	}
//
//	public MultipartFile getPhoto() {
//		return photo;
//	}
//
//	public void setPhoto(MultipartFile photo) {
//		this.photo = photo;
//	}
//
//	public String getBooknum() {
//		return booknum;
//	}
//
//	public void setBooknum(String booknum) {
//		this.booknum = booknum;
//	}
//
//	public String getMemid() {
//		return memid;
//	}
//
//	public void setMemid(String memid) {
//		this.memid = memid;
//	}
//
//	public String getBuname() {
//		return buname;
//	}
//
//	public void setBuname(String buname) {
//		this.buname = buname;
//	}
//
//	public String getRoomname() {
//		return roomname;
//	}
//
//	public void setRoomname(String roomname) {
//		this.roomname = roomname;
//	}
//
//	public String getBookcheckin() {
//		return bookcheckin;
//	}
//
//	public void setBookcheckin(String bookcheckin) {
//		this.bookcheckin = bookcheckin;
//	}
//
//	public String getBookcheckout() {
//		return bookcheckout;
//	}
//
//	public void setBookcheckout(String bookcheckout) {
//		this.bookcheckout = bookcheckout;
//	}
//
//	public String getBookpayment() {
//		return bookpayment;
//	}
//
//	public void setBookpayment(String bookpayment) {
//		this.bookpayment = bookpayment;
//	}
//
//	public String getBookprice() {
//		return bookprice;
//	}
//
//	public void setBookprice(String bookprice) {
//		this.bookprice = bookprice;
//	}
//
//	public String getBookregdate() {
//		return bookregdate;
//	}
//
//	public void setBookregdate(String bookregdate) {
//		this.bookregdate = bookregdate;
//	}
//
//	public int getRoomnum() {
//		return roomnum;
//	}
//
//	public void setRoomnum(int roomnum) {
//		this.roomnum = roomnum;
//	}
//
//	public int getBookstatus() {
//		return bookstatus;
//	}
//
//	public void setBookstatus(int bookstatus) {
//		this.bookstatus = bookstatus;
//	}

}
