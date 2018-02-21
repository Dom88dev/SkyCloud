package persistance;

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
			String sql = "insert into APPLIES(email, std_id, apply_status, apply_content, apply_datetime) values(?, ?, ?, ?, ?)";
			
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
	
	public int getCurrentMembersNum(int std_id) {
		int result = 0;
		try {
			String sql = "select count(email) from APPLIES group by std_id, apply_status having apply_status = 'accept' and std_id = ?";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getCurrentMembersNum() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
		
	}
	
	public int getApplyByEmail(String email){
		int result = 0;
		String sql = "select email from APPLIES where email=?";
		try{
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) result = 1;
		}catch(Exception e){
			System.out.println("getApplyByEmail() 에러 :" + e);
		}finally{
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return result;
	}
	
	public void deleteApply(int std_id) {
		String sql = "delete * from APPLIES where std_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("deleteApply() 에러 :" + e);
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
	}
}
