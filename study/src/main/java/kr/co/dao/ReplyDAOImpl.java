package kr.co.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Autowired
	SqlSession sql;

	//댓글조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList("replyMapper.readReply", bno);
	}

	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		sql.insert("replyMapper.writeReply", vo);
		
	}

	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		sql.update("replyMapper.updateReply", vo);
		
	}

	@Override
	public void deleteReply(ReplyVO vo) throws Exception {
		sql.delete("replyMapper.deleteReply", vo);
		
	}

	@Override
	public ReplyVO selectReply(int rno) throws Exception {
		return sql.selectOne("replyMapper.selectReply", rno);
	}

}
