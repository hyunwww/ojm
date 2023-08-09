package org.ojm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ojm.domain.Criteria;
import org.ojm.domain.QboardVO;

public interface QboardMapper {
	public List<QboardVO> getQlistWithPaging(Criteria cri);	// 전체 게시글 조회(+ 페이징)
	public int getQtotalCount();					// 전체 게시글 수 가져오기
	public int qInsert(QboardVO qvo);				// 게시글 삽입
	public int updateQreplyCnt(@Param("qno") int qno, @Param("amount") int amount);
	public int getQreplyCnt(int qno);
	public QboardVO qRead(int qno);					// 게시글 조회
	public int qUpdate(QboardVO qvo);				// 게시글 수정
	public int qDelete(int qno);					// 게시글 삭제
	public int updateQview(int qno);				// 조회수
}
