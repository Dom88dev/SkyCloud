package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.DBConnectionMgr;
import model.Study;

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
	
	public List<Study> getAllStduyList() {
		ArrayList<Study> list = new ArrayList<>();
		String sql = "select * from study";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Study s = new Study();
				s.setStudy(rs.getInt("std_id"), rs.getString("std_name"), rs.getInt("std_max"), rs.getDate("std_start"), rs.getDate("std_end"), rs.getString("std_info"), rs.getString("std_plan"), rs.getString("std_etc"), rs.getString("std_gender"), rs.getString("std_category"), rs.getString("email"));
				list.add(s);
			}
		} catch(Exception e) {
			System.out.println("getStudyList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	public List<Study> getStduyList() {
		ArrayList<Study> list = (ArrayList<Study>)getAllStduyList();
		ArrayList<Study> stdList = new ArrayList<>();
		String sql = "select count(email) from applies group by std_id having std_id = ?";
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
