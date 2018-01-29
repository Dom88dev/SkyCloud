package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import model.Attendance;
import model.Study;
import model.StudyTimePlace;

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
	public List<Attendance> getAttendenceList(int std_id){
		ArrayList<Attendance> list = new ArrayList<>();
		String sql="select email from applies where status='accept' and std_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Attendance  a= new Attendance();
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
	/*출석버튼 눌렀을때 상태 변경(스터디 시작시간보다 늦으면 지각, 스터디 하는요일에
	버튼이 안눌렸으면 결석(공결, 무단결석...))*/
	
	//1. 스터디 시작시간과 스터디 요일 가져오기
	public List<StudyTimePlace> getStudyTime() {
		ArrayList<StudyTimePlace> list = new ArrayList<>();
		Study s = new Study();
		String sql = "select std_time, std_day from study_timeplace where std_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s.getStd_id());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudyTimePlace st = new StudyTimePlace();
				st.setStd_id(s.getStd_id());
				st.setStd_day(rs.getString("std_day"));
				st.setStd_time(rs.getString("std_time"));
				list.add(st);
			}
		} catch(Exception e) {
			System.out.println("getTimePlaceList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return list;	
	}
	//2. 출석버튼 눌렀을 때 상태 변경
	public String InsertAttStatus(int std_id) throws ParseException {
		int result = 0;
		StudyTimePlace st = new StudyTimePlace();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		SimpleDateFormat rsdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		String currentTime = sdf.format(calendar.getTime());
		String reDay = rsdf.format(calendar.getTime());
		Date currentDay = rsdf.parse(reDay);
		
		String status=null;
		try {
			conn = pool.getConnection();
			String sql = "insert into attendance values(seq_atd.nextVal,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, (java.sql.Date) currentDay);
			if((st.getStd_time()).compareTo(currentTime)<0) {
				pstmt.setString(2, "late");
				status="late";
			}else if((st.getStd_time()).compareTo(currentTime)>0) {
				pstmt.setString(2, "att");
				status="att";
			}else {
				pstmt.setString(2, "abs");
				status="abs";
			}
			ArrayList<Attendance> list = (ArrayList<Attendance>) getAttendenceList(std_id);
			for(Attendance a : list) {
				pstmt.setString(3, a.getEmail());
			}
			pstmt.setInt(4, std_id);
			result = pstmt.executeUpdate();
			if(result<=0) status="fail";
		} catch(Exception e) {
			System.out.println("getTimePlaceList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return status;
	}
	//3. 출결현황 출력하기
	public String UpdateAttStatus(Attendance a){
		String sql = String.format("select email, atd_status from attendance where std_id='%s'", a.getStd_id());
		String msg = null;
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			msg = "[";
			while(rs.next()){
				if(!rs.isFirst()) msg += ",";
				msg += "{";
				msg += "\"email\" : "+ rs.getString("email")+",";
				msg += "\"ats_status\" : " + rs.getString("atd_status")+"\"";
				msg += "}";
			}
			msg += "]";
			return msg;
			
		} catch(Exception e) {
			System.out.println("UpdateAttStatus() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return null;
	}
	
	//잘못된 출석 상태 수정하기
	
	

}
