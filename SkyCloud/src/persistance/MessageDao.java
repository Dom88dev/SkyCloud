package persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MessageDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public MessageDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("StudyDao() 오류 : "+err);
		}
	}
	
	public int notiReplyOccured(String reciever, String writerName, String kind, int b_id, int std_id) {
		int result = 0;
		try {
			String sql = "insert into MESSAGE(msg_datetime, msg_href, msg_content, msg_check, reciever, sender) values(?, ?, ?, ?, ?, ?)";
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, System.currentTimeMillis());
			pstmt.setString(2, "/fwd?command=GOTOBOARD&board="+kind+"&b_id="+b_id+"&std_id="+std_id);
			pstmt.setString(3, writerName+"님이 회원님에게 댓글을 남겼습니다.");
			pstmt.setInt(4, 0);
			pstmt.setString(5, reciever);
			pstmt.setString(6, "study@cloud.com");
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("notiReplyOcured() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
}
