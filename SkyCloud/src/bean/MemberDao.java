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
	
	public Member getMemberByEmail(String email) {
		Member m = new Member();
		String sql = "select * from member where email = ?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			rs.next();
			m.setBorn(rs.getDate("born"));
			m.setEmail(email);
			m.setGender(rs.getString("gender"));
			m.setName(rs.getString("name"));
			m.setPw(rs.getString("pw"));
			m.setTel(rs.getString("tel"));
		} catch(Exception e) {
			System.out.println("getMemberByEmail() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return m;
	}
	public int getValidEmail(String email) {
		int result = 0;
		String sql="select email from member where email = ?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) result = 1;
		} catch (Exception e) {
			System.out.println("getValidEmail() 에러 : "+e);
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		System.out.println("email 결과 : "+result);
		return result;
	}
	
	public int getValidName(String name) {
		int result = 0;
		String sql="select name from member where name = ?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next()) result = 1;
		} catch (Exception e) {
			System.out.println("getValidName() 에러 : "+e);
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		System.out.println("name 결과 : "+result);
		return result;
	}
	
	public int getValidTel(String tel) {
		int result = 0;
		String sql="select tel from member where tel = ?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tel);
			rs = pstmt.executeQuery();
			if(rs.next()) result = 1;
		} catch (Exception e) {
			System.out.println("getValidTel() 에러 : "+e);
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		System.out.println("tel 결과 : "+result);
		return result;
	}
	//회원정보 수정
	public int UpdateMemInfo(Member m){
		int result=0;
		String sql = "update member set pw=?, name=?, tel=? where email=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getPw());
			pstmt.setString(2, m.getName());
			pstmt.setString(3, m.getTel());
			pstmt.setString(4, m.getEmail());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("UpdateMemInfo() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}
	//회원탈퇴시 정보 삭제
	public int deleteMem() {
		int result=0;
		
		return result;
	}
}
