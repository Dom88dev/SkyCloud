package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Member;

public class MemberDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public MemberDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("MemberDao() 오류 : "+err);
		}
	}
	
	public int insertMember(Member m) {
		int result = 0;
		try {
			conn = pool.getConnection();
			String sql = "insert into MEMBER values(?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getEmail());
			pstmt.setString(2, m.getPw());
			pstmt.setString(3, m.getName());
			pstmt.setString(4, m.getTel());
			pstmt.setString(5, m.getGender());
			pstmt.setDate(6, m.getBorn());
			result = pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("insertMember() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
}
