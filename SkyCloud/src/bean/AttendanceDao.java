package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Attendance;
import model.Study;

public class AttendanceDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public AttendanceDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("AttendanceDao() 오류 : "+err);
		}
	}	
	//해당 스터디를 수강하는 사람들의 정보(이메일)를 가져온다.
	public List<Attendance> getAttendenceList(Study s){
		ArrayList<Attendance> list = new ArrayList<>();
		String sql="select email from applies where status='accept' and std_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s.getStd_id());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Attendance a = new Attendance();
				a.setAttendance(rs.getInt("atd_id"), rs.getDate("atd_date"), rs.getString("atd_status"), rs.getString("email"), rs.getInt("std_id"));
				list.add(a);
			}
		} catch(Exception e) {
			System.out.println("getAttendenceList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return list;
	}
	//스터디 수강하는 사람들의 출석상태 업데이트/가져오기
	

}
