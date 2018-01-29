package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ApplyDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public ApplyDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("StudyDao() 오류 : "+err);
		}
	}
	
	
	//DB applies 테이블에 스터디 신청내역 삽입처리
	public int insertApply(String email, int std_id, String apply_status, String apply_content, long apply_datetime) {
		int result = 0;
		try {
			conn = pool.getConnection();
			String sql = "insert into APPLIES values(seq_apply.nextVal, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, std_id);
			pstmt.setString(3, apply_status);
			pstmt.setString(4, apply_content);
			pstmt.setLong(5, apply_datetime);
			result = pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("insertApply() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
}