package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Homework;
import model.Notice;

public class BoardDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public BoardDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("BoardDao() 오류 : "+err);
		}
	}
	
	public List<Notice> getNoticeList(int std_id) {
		ArrayList<Notice> noticeList = new ArrayList<>();
		String sql = "select * from board where std_id = ? and duedate is null order by b_datetime desc";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Notice n = new Notice();
				n.setB_id(rs.getInt("b_id"));
				n.setB_datetime(rs.getLong("b_datetime"));
				n.setStd_id(std_id);
				n.setContent(rs.getString("content"));
				n.setTitle(rs.getString("title"));
				n.setReplies_cnt(rs.getInt("replies_cnt"));
				n.setView_cnt(rs.getInt("view_cnt"));
				noticeList.add(n);
			}
		} catch(Exception e) {
			System.out.println("getNoticeList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return noticeList;
	}
	
	
	public List<Homework> getHomeworkList(int std_id) {
		ArrayList<Homework> hoemworkList = new ArrayList<>();
		String sql = "select * from board where std_id = ? and duedate is not null order by b_datetime desc";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, std_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Homework h = new Homework();
				h.setB_id(rs.getInt("b_id"));
				h.setB_datetime(rs.getLong("b_datetime"));
				h.setStd_id(std_id);
				h.setContent(rs.getString("content"));
				h.setTitle(rs.getString("title"));
				h.setReplies_cnt(rs.getInt("replies_cnt"));
				h.setView_cnt(rs.getInt("view_cnt"));
				h.setDuedate(rs.getLong("duedate"));
				hoemworkList.add(h);
			}
		} catch(Exception e) {
			System.out.println("getHomeworkList() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return hoemworkList;
	}
}
