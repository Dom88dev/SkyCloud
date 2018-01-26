package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.DBConnectionMgr;
import model.Study;
import model.StudyTimePlace;

public class StudyDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public StudyDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("StudyDao() 오류 : "+err);
		}
	}
	
	public List<StudyTimePlace> getTimePlaceList(int std_id) {
		ArrayList<StudyTimePlace> list = new ArrayList<>();
		String sql = "select * from study_timeplace where std_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudyTimePlace tp = new StudyTimePlace();
				tp.setStd_id(std_id);
				tp.setStd_addr(rs.getString("std_addr"));
				tp.setStd_day(rs.getString("std_day"));
				tp.setStd_hour(rs.getInt("std_hour"));
				tp.setStd_time(rs.getString("std_time"));
				list.add(tp);
			}
		} catch(Exception e) {
			System.out.println("getTimePlaceList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	//모든 스터디 리스트를 구하는 메서드
	public List<Study> getAllStduyList() {
		ArrayList<Study> list = new ArrayList<>();
		String sql = "select * from study";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//전체 스터디 목록을 DB의 스터디 테이블에서 불러옴.
			while(rs.next()) {
				Study s = new Study();
				s.setStudy(rs.getInt("std_id"), rs.getString("std_name"), rs.getInt("std_max"), rs.getDate("std_start"), rs.getDate("std_end"), rs.getString("std_info"), rs.getString("std_plan"), rs.getString("std_etc"), rs.getString("std_gender"), rs.getString("std_category"), rs.getString("email"));
				list.add(s);
			}
			
			//각각의 스터디에 해당하는 시간장소 리스트를 추가해준다.
			for(Study s : list) {
				ArrayList<StudyTimePlace> tpList = new ArrayList<>();
				tpList = (ArrayList<StudyTimePlace>)getTimePlaceList(s.getStd_id());
				s.setTimePlaceList(tpList);
			}
		} catch(Exception e) {
			System.out.println("getStudyList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	//메인페이지 및 스터디 검색 페이지에서 뿌려줄 스터디 목록을 구하는 메서드(정원이 다 차지 않은 스터디 리스트)
	public List<Study> getStduyList() {
		ArrayList<Study> list = (ArrayList<Study>)getAllStduyList();
		ArrayList<Study> stdList = new ArrayList<>();
		String sql = "select count(email) from applies group by std_id having std_id = ? and apply_status='accept'";
		try {
			conn = pool.getConnection();
			for(Study s : list) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, s.getStd_id());
				rs = pstmt.executeQuery();
				rs.next();
				if(s.getStd_max()>rs.getInt(1)){
					if(System.currentTimeMillis()<s.getStd_end().getTime()){
						stdList.add(s);
					}
				}
			}
		} catch(Exception e) {
			System.out.println("getStudyList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return stdList;
	}
}
