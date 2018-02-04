package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.BoardFile;
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
	
	//공지사항 등록
	public int insertNotice(Notice n, BoardFile bf) {
		int result = 0;
		String sql = "insert into BOARD values(seq_b.nextVal, ?, ?, ?, ?, null, 0, 0)";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n.getStd_id());
			pstmt.setString(2, n.getTitle());
			pstmt.setString(3, n.getContent());
			pstmt.setLong(4, n.getB_datetime());
			result = pstmt.executeUpdate();
			if(result >0) {
				sql = "select b_id from BOARD where std_id=? and title=? and content=? and b_datetime=? and duedate=null and view_cnt=0 and replies_cnt=0 order by b_id desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, n.getStd_id());
				pstmt.setString(2, n.getTitle());
				pstmt.setString(3, n.getContent());
				pstmt.setLong(4, n.getB_datetime());
				rs = pstmt.executeQuery();
				if(rs.next()) n.setB_id(rs.getInt("b_id"));
			}
			result = insertBoardFile(n.getB_id(), bf);			
		} catch(Exception err) {
			System.out.println("insertNotice() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	//과제등록
	public int insertHomework(Homework h, BoardFile bf) {
		int result = 0;
		String sql = "insert into BOARD values(seq_b.nextVal, ?, ?, ?, ?, ?, 0, 0)";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, h.getStd_id());
			pstmt.setString(2, h.getTitle());
			pstmt.setString(3, h.getContent());
			pstmt.setLong(4, h.getB_datetime());
			pstmt.setLong(5, h.getDuedate());
			result = pstmt.executeUpdate();
			if(result >0) {
				sql = "select b_id from BOARD where std_id=? and title=? and content=? and b_datetime=? and duedate=? and view_cnt=0 and replies_cnt=0 order by b_id desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, h.getStd_id());
				pstmt.setString(2, h.getTitle());
				pstmt.setString(3, h.getContent());
				pstmt.setLong(4, h.getB_datetime());
				pstmt.setLong(5, h.getDuedate());
				rs = pstmt.executeQuery();
				if(rs.next()) h.setB_id(rs.getInt("b_id"));
			}
			result = insertBoardFile(h.getB_id(), bf);
		} catch(Exception err) {
			System.out.println("insertHomework() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	//게시판 첨부 파일 등록
	public int insertBoardFile(int b_id, BoardFile bf) {
		int result = 0;
		String sql = "insert into BOARD_FILE values("+b_id+", ?, ?, ?, ?, ?, ?)";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bf.getB_file1_name());
			pstmt.setString(2, bf.getB_file1());
			pstmt.setString(3, bf.getB_file2_name());
			pstmt.setString(4, bf.getB_file2());
			pstmt.setString(5, bf.getB_file3_name());
			pstmt.setString(6, bf.getB_file3());
			result = pstmt.executeUpdate();
		} catch(Exception err) {
			System.out.println("insertBoardFile() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
}
