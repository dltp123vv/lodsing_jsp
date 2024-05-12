package com.academy.lodsing.business;

import org.springframework.web.multipart.MultipartFile;


//@Getter @Setter
public class Business {
	/**
	 * 
	 */
	private String ownid ;
	/**
	 * 
	 */
	private String ownname ;
	/**
	 * 
	 */
	private String ownpwd;
	/**
	 * 
	 */
	private String owntel ;
	/**
	 * 
	 */
	private String bucity ;
	/**
	 * 
	 */
	private String bucounty ;
	/**
	 * 
	 */
	private String buname ;
	/**
	 * 
	 */
	private String buaddr ;
	/**
	 * 
	 */
	private String bucate ;
	/**
	 * 
	 */
	private String filename ;
	/**
	 * 
	 */
	private String approval ;
	/**
	 * 파일을 업로드하는 클래스
	 */
	private MultipartFile photo;
	
	
	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public MultipartFile getPhoto() {
		return photo;
	}

	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}

	public String getOwnid() {
		return ownid;
	}

	public void setOwnid(String ownid) {
		this.ownid = ownid;
	}

	public String getOwnname() {
		return ownname;
	}

	public void setOwnname(String ownname) {
		this.ownname = ownname;
	}

	public String getOwnpwd() {
		return ownpwd;
	}

	public void setOwnpwd(String ownpwd) {
		this.ownpwd = ownpwd;
	}

	public String getOwntel() {
		return owntel;
	}

	public void setOwntel(String owntel) {
		this.owntel = owntel;
	}
	
	

	public String getBucity() {
		return bucity;
	}

	public void setBucity(String bucity) {
		this.bucity = bucity;
	}

	public String getBucounty() {
		return bucounty;
	}

	public void setBucounty(String bucounty) {
		this.bucounty = bucounty;
	}

	public String getBuname() {
		return buname;
	}

	public void setBuname(String buname) {
		this.buname = buname;
	}

	public String getBuaddr() {
		return buaddr;
	}

	public void setBuaddr(String buaddr) {
		this.buaddr = buaddr;
	}

	public String getBucate() {
		return bucate;
	}

	public void setBucate(String bucate) {
		this.bucate = bucate;
		
	}
	

	
	
}
