package com.academy.lodsing.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

//
@Mapper
public interface ReviewMapper {
	
	/**
	 * 리뷰 점수 조회
	 * @param buname
	 * @return
	 */
	public List<Review> getRating(
			@Param("buname") String buname
			);
	
	/**
	 * 전체 게시글 조회
	 * @param buname
	 * @return
	 */
	public List<Review> getReviews(
			@Param("buname") String buname
			);
	
	/**
	 *  상세보기를 위한 게시글 한 건 조회
	 * @param idx
	 * @return
	 */
	public Review getReview(
			@Param("idx") int idx
			); 
	
	/**
	 * 새글추가
	 * @param vo
	 * @return
	 */
	public int insertReview(
			@Param("review") Review review
			);
	
	/**
	 * 리뷰 삭제하기
	 * @param idx
	 * @return
	 */
	public int delete(
			@Param("idx") int idx
			); 
	
	
	/**
	 * 해당 리뷰 조회
	 * @param idx
	 * @return
	 */
	public Review findOne(
			@Param("idx") int idx
			);
	
	/**
	 * 리뷰 수정하기
	 * @param vo
	 * @return
	 */
	public int modify(
			@Param("review") Review review
			);
//	{
//		int res = sqlSession.update("review.review_modify", vo);
//
//		return res;
//	}
//	{
//		ReviewVO vo = sqlSession.selectOne("review.review_idx", idx);
//		return vo;
//	}
//	{
//		int res = sqlSession.delete("review.review_delete", idx);
//		return res;
//	}
//	{
//		ReviewVO vo = sqlSession.selectOne("review.review_one", idx);
//		return vo;
//	}
//
//	SqlSession sqlSession;
//
//	public void setSqlSession(SqlSession sqlSession) {
//		this.sqlSession = sqlSession;
//	}
//
//	public ReviewDAO(SqlSession sqlSession) {
//		this.sqlSession = sqlSession;
//		System.out.println("---GogaekDAO생성자---");
//		System.out.println("sql : " + this.sqlSession);
//
//	}
//
//
//	//전체 게시글 조회
//		public List<ReviewVO> selectList(){
//			List<ReviewVO> relist = sqlSession.selectList("review.review_list");
//			return relist;
//		}
//
//	// 새글추가
//	public int insert(ReviewVO vo) {
//		int res = sqlSession.insert("review.review_insert", vo);
//		return res;
//	}
//
//	// 상세보기를 위한 게시글 한 건 조회
//	public ReviewVO selectOne(int idx) {
//		ReviewVO vo = sqlSession.selectOne("review.review_one", idx);
//		return vo;
//	}
//
//	// 댓글 작성을 위한 step값 증가
//	public int update_step(ReviewVO vo) {
//
//		int res = sqlSession.update("review.update_step", vo);
//		return res;
//
//	}
//
//	// 댓글 작성
//	public int reply(ReviewVO vo) {
//		int res = sqlSession.insert("review.review_reply", vo);
//		return res;
//
//	}
//
//	// 삭제하기
//	public int delete(int idx) {
//		int res = sqlSession.delete("review.review_delete", idx);
//		return res;
//	}
//
//	// 전체 게시물 수 조회
//	public int getRowTotal() {
//		int count = sqlSession.selectOne("review.review_count");
//		return count;
//	}
//
//	// idx�� �޾Ƽ� ��ȸ
//	public ReviewVO selectIdx(int idx) {
//		ReviewVO vo = sqlSession.selectOne("review.review_idx", idx);
//		return vo;
//	}
//
//	public ReviewVO selectBuname(String buname) {
//		ReviewVO vo = sqlSession.selectOne("review.review_buname", buname);
//		return vo;
//	}
//
//	// 수정하기
//	public int modify(ReviewVO vo) {
//		int res = sqlSession.update("review.review_modify", vo);
//
//		return res;
//	}
//	
//	
//
}

