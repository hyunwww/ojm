package org.ojm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ojm.domain.BoardVO;
import org.ojm.domain.Criteria;

public interface BoardMapper {
	public int insert(BoardVO vo);		// 게시글 삽입
	public BoardVO read(int bno);		// 게시글 조회
	public int delete(int bno);			// 게시글 삭제
	public int update(BoardVO vo);		// 게시글 수정
	public List<BoardVO> getListWithPaging(Criteria cri);	// 전체 게시글 조회(+ 페이징)
	public int getTotalCount();			// 전체 게시글 수 가져오기
	public int updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);
	public int getMaxBno();
	public int updateBview(int bno);	// 조회수
	public int updateBlikeUp(int bno);		// 좋아요 up
	public int updateBlikeDown(int bno);	// 좋아요 down
	public int getReplyCnt(int bno);	// 댓글 수 가져오기
}
