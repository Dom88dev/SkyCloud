package persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import model.Attendance;
import model.Member;
import model.Study;
import model.StudyTimePlace;
import util.Util;

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
		String sql="select * from ATTENDANCE where std_id=? and atd_date =?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String d = sdf.format(new Date());
			java.sql.Date date = Util.transDate(d);
			pstmt.setDate(2, date);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Attendance  a= new Attendance();
				a.setEmail(rs.getString("email"));
				a.setAtd_id(rs.getInt("atd_id"));
				a.setAtd_date(rs.getDate("atd_date"));
				a.setAtd_status(rs.getString("atd_status"));
				a.setStd_id(rs.getInt("std_id"));
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
		
	//1.스터디 시작시간 가져오기
	public String getStdTime(int std_id) {
		String time=null;
		String sql="select std_time from STUDY_TIMEPLACE where std_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				time = rs.getString("std_time");
			}
		} catch(Exception e) {
			System.out.println("getTimePlaceList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return time;
	}
	//2. 출석버튼 눌렀을 때 상태 변경
	public String InsertAttStatus(int std_id, String email){
		//int result = 0;
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		//SimpleDateFormat rsdf = new SimpleDateFormat("yyyy-MM-dd");
		//Calendar calendar = Calendar.getInstance();
		//String currentTime = sdf.format(calendar.getTime());
		//String reDay = rsdf.format(calendar.getTime());
		//Date currentDay = rsdf.parse(reDay);
		Date date = new Date();
		int d = date.getDate();
		int m = date.getMonth();
		int y = date.getYear();
		String str = sdf.format(date);
		java.sql.Date sqlDate = new java.sql.Date(y, m, d);
		System.out.println(sqlDate);
		System.out.println("현재날짜 hhmm : "+str);
		String status=null;
		String stdTime = getStdTime(std_id);
		System.out.println("스터디 시작시간 hhmm : "+stdTime);
		try {
			conn = pool.getConnection();
			String sql = "insert into attendance(atd_date, atd_status, email, std_id) values(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, sqlDate);
			if(stdTime.compareTo(str)<0) {
				pstmt.setString(2, "late");
				status="late";

			}else if(stdTime.compareTo(str)>0) {
				pstmt.setString(2, "att");
				status="att";

			}else {
				pstmt.setString(2, "abs");
				status="abs";

			}
			pstmt.setString(3, email);
			pstmt.setInt(4, std_id);
			pstmt.executeUpdate();
			System.out.println(status);
			//if(result<=0) status="fail";
		} catch(Exception e) {
			System.out.println("InsertAttStatus() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		System.out.println(email+"의 출결상황 : "+status);
		return status;
	}
	//3. 출결현황 출력하기
	public String getAttStatus(Attendance a){
		String sql = String.format("select email, atd_status from ATTENDANCE where std_id='%s'", a.getStd_id());
		String msg = null;
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				if(!rs.isFirst()) msg += ",";
				msg += "{";
				msg += "\"email\" : "+ rs.getString("email")+",";
				msg += "\"atd_status\" : \"" + rs.getString("atd_status")+"\"";
				msg += "}";
			}
			msg +=",";
			return msg;
			
		} catch(Exception e) {
			System.out.println("getAttStatus() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return msg;
	}
	//잘못된 출석 상태 수정하기
	public int UpdateStatus(String upatd, String email) {
		int result=0;
		String sql = "update attendance set atd_status=? where email=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, upatd);
			pstmt.setString(2, email);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("UpdateAttStatus() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}
	
	public String getMemStatus(String email){
		String status = null;

		String sql = "select atd_status from ATTENDANCE where email=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while(rs.next()){
				status = rs.getString("atd_status");
			}			
		} catch(Exception e) {
			System.out.println("getMemStatus() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return status;
	}
	public Date getMemAtdDate(String email){
		Date date = null;
		String sql = "select atd_date from ATTENDANCE where email=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while(rs.next()){
				date = new Date(rs.getDate("atd_date").getTime());
			}			
		} catch(Exception e) {
			System.out.println("getMemAtdDate() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return date;		
	}
}
