package persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Member;
import model.Message;
import model.Notice;

public class MessageDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;

	public MessageDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception err) {
			System.out.println("MessageDao() 오류 : " + err);
		}
	}

	// 쪽지 목록 불러오기
	public List<Message> getMsgList(String reciever) {
		ArrayList<Message> msgList = new ArrayList<>();
		String sql = "select * from MESSAGE where reciever=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reciever);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Message m = new Message();
				m.setMsg_id(rs.getInt("msg_id"));
				m.setMsg_check(rs.getInt("msg_check"));
				m.setMsg_content(rs.getString("msg_content"));
				m.setMsg_datetime(rs.getLong("msg_datetime"));
				m.setMsg_href(rs.getString("msg_href"));
				m.setReciever(rs.getString("reciever"));
				m.setSender(rs.getString("sender"));

				msgList.add(m);
			}
		} catch (Exception e) {
			System.out.println("getMsgList 에러 : " + e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return msgList;
	}

	// 쪽지 정보 가져오기
	public Message getMsg(int msg_id) {
		Message m = new Message();
		String sql = "select * from MESSAGE where msg_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, msg_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				m.setMsg_id(rs.getInt("msg_id"));
				m.setMsg_check(rs.getInt("msg_check"));
				m.setMsg_content(rs.getString("msg_content"));
				m.setMsg_datetime(rs.getLong("msg_datetime"));
				m.setMsg_href(rs.getString("msg_href"));
				m.setReciever(rs.getString("reciever"));
				m.setSender(rs.getString("sender"));
			}
		} catch (Exception e) {
			System.out.println("getNotice() 에러 : " + e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return m;
	}

	// 쪽지 등록
	public int insertMessage(Message m) {
		int result = 0;
		String sql = "insert into MESSAGE(msg_datetime, msg_href, msg_content, msg_check, reciever, sender) values(?,?,?,?,?,?)";
		try {
			conn = pool.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, m.getMsg_datetime());
			pstmt.setString(2, m.getMsg_href());
			pstmt.setString(3, m.getMsg_content());
			pstmt.setLong(4, m.getMsg_check());
			pstmt.setString(5, m.getReciever());
			pstmt.setString(6, m.getSender());
			result = pstmt.executeUpdate();
		} catch (Exception err) {
			System.out.println("insertMessage() 에러 : " + err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int getMsg_IdFromMessage(Message m) {
		int result = 0;
		String sql = "select msg_id from MESSAGE where msg_content=? and reciever=? and msg_datetime=? order by msg_id desc";
		try{
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getMsg_content());
			pstmt.setString(2, m.getReciever());
			pstmt.setLong(3, m.getMsg_datetime());
			rs = pstmt.executeQuery();
			if(rs.next()) result =  rs.getInt("msg_id");
		} catch(Exception err) {
			System.out.println("getMsg_IdFromMessage() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
		
	}
	
	//쪽지 갯수 가져오기
	public int MemoCheck(String email) {
		int result = 0;
		String sql="select count(*) from MESSAGE where email=?";
		try{
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) result =  rs.getInt(1);
		} catch(Exception err) {
			System.out.println("getMsg_IdFromMessage() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
}
