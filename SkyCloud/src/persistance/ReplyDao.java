package persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Replies;

public class ReplyDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public ReplyDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("StudyDao() 오류 : "+err);
		}
	}
	
	//댓글
	public int insertReply(int b_id, String rp_content, String writer) {
		int result = 0;
		try {
			conn = pool.getConnection();
			String sql = "select max(rp_pos) from REPLIES group by b_id having b_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) result = rs.getInt(1);
			
			int pos = result+1;
			
			sql = "insert into REPLIES(b_id, rp_pos, rp_depth, rp_content, rp_datetime, rp_writer) values(?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.setInt(2, pos);
			pstmt.setInt(3, 0);
			pstmt.setString(4, rp_content);
			pstmt.setLong(5, System.currentTimeMillis());
			pstmt.setString(6, writer);
			result = pstmt.executeUpdate();
			
			sql = "update BOARD set replies_cnt=replies_cnt+1 where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("insertReply() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	//대댓글
	public int insertRereply(int b_id, String rp_content, String writer, String reciever, int rp_pos) {
		int result = 0;
		try {
			conn = pool.getConnection();
			String sql = "update REPLIES set rp_pos=rp_pos+1 where b_id=? and rp_pos>"+rp_pos;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
			
			sql = "select max(rp_depth) from REPLIES group by b_id having b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) result = rs.getInt(1);
			int depth = result+1;
			sql = "insert into REPLIES(b_id, rp_pos, rp_depth, rp_content, rp_datetime, rp_writer, rp_reciever) values(?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.setInt(2, rp_pos+1);
			pstmt.setInt(3, depth);
			pstmt.setString(4, rp_content);
			pstmt.setLong(5, System.currentTimeMillis());
			pstmt.setString(6, writer);
			pstmt.setString(7, reciever);
			result = pstmt.executeUpdate();
			
			sql = "update BOARD set replies_cnt=replies_cnt+1 where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("insertRereply() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	
	public List<Replies> getReplies(int b_id) {
		ArrayList<Replies> replies = new ArrayList<>();
		try {
			String sql = "select * from REPLIES where b_id=? order by rp_pos, rp_depth asc";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Replies rp = new Replies();
				rp.setB_id(b_id);
				rp.setRp_content(rs.getString("rp_content"));
				rp.setRp_datetime(rs.getLong("rp_datetime"));
				rp.setRp_depth(rs.getInt("rp_depth"));
				rp.setRp_pos(rs.getInt("rp_pos"));
				rp.setRp_id(rs.getInt("rp_id"));
				rp.setRp_reciever(rs.getString("rp_reciever"));
				rp.setRp_writer(rs.getString("rp_writer"));
				replies.add(rp);
			}
			
			for(Replies r : replies) {
				sql = "select name from MEMBER where email=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, r.getRp_writer());
				rs = pstmt.executeQuery();
				if(rs.next()) r.setWriter(rs.getString(1));
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, r.getRp_reciever());
				rs = pstmt.executeQuery();
				if(rs.next()) r.setReciever(rs.getString(1));
			}
			
		} catch(Exception err) {
			System.out.println("getReplies() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return replies;
	}
	
	public int updateReply(int rp_id, String rp_content) {
		int result=0;
		try {
			String sql = "update REPLIES set rp_content=?, rp_datetime=? where rp_id=?";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rp_content);
			pstmt.setLong(2, System.currentTimeMillis());
			pstmt.setInt(3, rp_id);
			result = pstmt.executeUpdate();		
			
		} catch(Exception err) {
			System.out.println("updateReply() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int deleteReply(int rp_id, int b_id) {
		int result=0;
		try {
			String sql = "delete from REPLIES where rp_id=?";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rp_id);
			result = pstmt.executeUpdate();
			
			sql = "update BOARD set replies_cnt=replies_cnt-1 where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("deleteReply() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public void deleteReplyByWriter(String email){
		String sql = "delete from REPLIES where rp_writer=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("deleteReplyByWriter() 에러 :" + e);
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
	}
}
