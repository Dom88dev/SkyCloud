package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
		String sql = "select * from study order by std_id desc";
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
		String sql = "select count(email), apply_status from applies group by std_id, apply_status having std_id = ?";
		try {
			conn = pool.getConnection();
			for(Study s : list) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, s.getStd_id());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					int memNum = rs.getInt(1);
					String status = rs.getString(2);
					System.out.println(memNum + "/"+s.getStd_max());
					if(status.equals("accept")) {
						if(s.getStd_max()>memNum){
							System.out.println(System.currentTimeMillis() + " : "+ s.getStd_end().getTime());
							if(System.currentTimeMillis()<s.getStd_end().getTime()){
								stdList.add(s);
							}
						}
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
	
	//study테이블에 insert 처리 후 std_id 반환
	public int insertStudy(Study s) {
		int result = 0;
		
		try {
			conn = pool.getConnection();
			String sql = "insert into STUDY values(seq_std.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s.getStd_name());
			pstmt.setInt(2, s.getStd_max());
			pstmt.setDate(3, s.getStd_start());
			pstmt.setDate(4, s.getStd_end());
			pstmt.setString(5, s.getStd_info());
			pstmt.setString(6, s.getStd_plan());
			pstmt.setString(7, s.getStd_etc());
			pstmt.setString(8, s.getStd_gender());
			pstmt.setString(9, s.getStd_category());
			pstmt.setString(10, s.getEmail());
			result = pstmt.executeUpdate();
			
			if(result>0) {//if insert 성공했다면 std_id를 가져옴.
				sql="select std_id from STUDY where std_name=? and std_max=? and std_start=? and std_end=? and std_info=? and std_plan=? and std_etc=? and std_gender=? and std_category=? and email=? order by std_id desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, s.getStd_name());
				pstmt.setInt(2, s.getStd_max());
				pstmt.setDate(3, s.getStd_start());
				pstmt.setDate(4, s.getStd_end());
				pstmt.setString(5, s.getStd_info());
				pstmt.setString(6, s.getStd_plan());
				pstmt.setString(7, s.getStd_etc());
				pstmt.setString(8, s.getStd_gender());
				pstmt.setString(9, s.getStd_category());
				pstmt.setString(10, s.getEmail());
				rs = pstmt.executeQuery();
				rs.next();
				result = rs.getInt("std_id");
			}
		} catch(Exception err) {
			System.out.println("insertStudy() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	
	// study_timeplace테이블에 insert 처리
	public int insertStudyTimePlace(StudyTimePlace tp) {
		int result = 0;
		
		try {
			conn = pool.getConnection();
			String sql = "insert into STUDY_TIMEPLACE values(?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tp.getStd_time());
			pstmt.setInt(2, tp.getStd_hour());
			pstmt.setString(3, tp.getStd_addr());
			pstmt.setString(4, tp.getStd_day());
			pstmt.setInt(5, tp.getStd_id());
			result = pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("insertStudyTimePlace() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	//study 테이블 내 수정
	public int updateStudy(int std_id, Study std) {
		int result=0;
		String sql = "";
		return result;
	}
	
	//Study 검색 (스터디 이름과 소개 내용으로 검색)
	public List<Study> getSearchStudyListOnNavbar(String search) {
		ArrayList<Study> list = (ArrayList<Study>)getAllStduyList();
		ArrayList<Study> stdList = new ArrayList<>();
		for(Study s : list) {
			if(s.getStd_name().contains(search) || s.getStd_info().contains(search))	stdList.add(s);
		}
		return stdList;
	}
}
