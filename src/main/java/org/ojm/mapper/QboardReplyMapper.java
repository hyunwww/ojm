package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.QboardReplyVO;

public interface QboardReplyMapper {
	public int qInsert(QboardReplyVO qvo);			// 댓글 삽입
	public List<QboardReplyVO> getQlist(int qno);	// 댓글 목록
	public int qDelete(int qrno, int qno);			// 댓글 삭제
	public int qDeleteAll(int qno);					// 댓글 전체 삭제
}
