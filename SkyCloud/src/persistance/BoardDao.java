package persistance;

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
	
	public BoardFile getBoardFile(int b_id) {
		BoardFile bf = new BoardFile();
		String sql = "select * from BOARD_FILE where b_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bf.setB_id(b_id);
				bf.setB_file1(rs.getString("b_file1"));
				bf.setB_file1_name(rs.getString("b_file1_name"));
				bf.setB_file2(rs.getString("b_file2"));
				bf.setB_file2_name(rs.getString("b_file2_name"));
				bf.setB_file3(rs.getString("b_file3"));
				bf.setB_file3_name(rs.getString("b_file3_name"));
			}
		} catch(Exception e) {
			System.out.println("getBoardFile() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return bf;
	}
	
	//공지사항 정보 가져오기
	public Notice getNotice(int b_id) {
		Notice n = new Notice();
		String sql = "select * from BOARD where b_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				n.setB_id(b_id);
				n.setTitle(rs.getString("title"));
				n.setContent(rs.getString("content"));
				n.setStd_id(rs.getInt("std_id"));
				n.setB_datetime(rs.getLong("b_datetime"));
				n.setReplies_cnt(rs.getInt("replies_cnt"));
				n.setView_cnt(rs.getInt("view_cnt"));
				n.setFiles(getBoardFile(b_id));
			}
		} catch(Exception e) {
			System.out.println("getNotice() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return n;
	}
	
	//과제 정보 가져오기
	public Homework getHomework(int b_id) {
		Homework h = new Homework();
		String sql = "select * from BOARD where b_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				h.setB_id(b_id);
				h.setTitle(rs.getString("title"));
				h.setContent(rs.getString("content"));
				h.setStd_id(rs.getInt("std_id"));
				h.setB_datetime(rs.getLong("b_datetime"));
				h.setReplies_cnt(rs.getInt("replies_cnt"));
				h.setView_cnt(rs.getInt("view_cnt"));
				h.setDuedate(rs.getLong("duedate"));
				h.setFiles(getBoardFile(b_id));
			}
		} catch(Exception e) {
			System.out.println("getHomework() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return h;
	}
	
	
	public List<Notice> getNoticeList(int std_id) {
		ArrayList<Notice> noticeList = new ArrayList<>();
		String sql = "select * from BOARD where std_id = ? and duedate is null order by b_datetime desc";
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
		String sql = "select * from BOARD where std_id = ? and duedate is not null order by b_datetime desc";
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
	
	//공지사항 등록 - b_id 반환 -> 바로 insertBoardFile을 실행할 수 있도록
	public int insertNotice(Notice n) {
		int result = 0;
		String sql = "insert into BOARD(std_id, title, content, b_datetime, duedate, view_cnt, replies_cnt) values(?, ?, ?, ?, null, 0, 0)";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n.getStd_id());
			pstmt.setString(2, n.getTitle());
			pstmt.setString(3, n.getContent());
			pstmt.setLong(4, n.getB_datetime());
			result = pstmt.executeUpdate();
		} catch(Exception err) {
			System.out.println("insertNotice() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	//과제등록 - b_id 반환 -> 바로 insertBoardFile을 실행할 수 있도록
	public int insertHomework(Homework h) {
		int result = 0;
		String sql = "insert into BOARD(std_id, title, content, b_datetime, duedate, view_cnt, replies_cnt) values(?, ?, ?, ?, ?, 0, 0)";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, h.getStd_id());
			pstmt.setString(2, h.getTitle());
			pstmt.setString(3, h.getContent());
			pstmt.setLong(4, h.getB_datetime());
			pstmt.setLong(5, h.getDuedate());
			result = pstmt.executeUpdate();
		} catch(Exception err) {
			System.out.println("insertHomework() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int getB_IdFromHomework(Homework h) {
		int result = 0;
		String sql = "select b_id from BOARD where std_id=? and title=? and content=? and b_datetime=? and duedate=? order by b_id desc";
		try{
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, h.getStd_id());
			pstmt.setString(2, h.getTitle());
			pstmt.setString(3, h.getContent());
			pstmt.setLong(4, h.getB_datetime());
			pstmt.setLong(5, h.getDuedate());
			rs = pstmt.executeQuery();
			if(rs.next()) result =  rs.getInt("b_id");
		} catch(Exception err) {
			System.out.println(" getB_IdFromHomework() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
		
	}
	
	public int getB_IdFromNotice(Notice n) {
		int result = 0;
		String sql = "select b_id from BOARD where std_id=? and title=? and content=? and b_datetime=? order by b_id desc";
		try{
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n.getStd_id());
			pstmt.setString(2, n.getTitle());
			pstmt.setString(3, n.getContent());
			pstmt.setLong(4, n.getB_datetime());
			rs = pstmt.executeQuery();
			if(rs.next()) result =  rs.getInt("b_id");
		} catch(Exception err) {
			System.out.println(" getB_IdFromNotice() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
		
	}
	
	//게시판 첨부 파일 등록
	public int insertBoardFile(int b_id, BoardFile bf) {
		int result = 0;
		String sql = "insert into BOARD_FILE(b_id, b_file1_name, b_file1, b_file2_name, b_file2, b_file3_name, b_file3) values(?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			if(bf.getB_file1_name()==null) pstmt.setNull(2, java.sql.Types.NULL);
			else pstmt.setString(2, bf.getB_file1_name());
			if(bf.getB_file1()==null) pstmt.setNull(3, java.sql.Types.NULL);
			else pstmt.setString(3, "/upload/"+bf.getB_file1());
			if(bf.getB_file2_name()==null) pstmt.setNull(4, java.sql.Types.NULL);
			else pstmt.setString(4, bf.getB_file2_name());
			if(bf.getB_file2()==null) pstmt.setNull(5, java.sql.Types.NULL);
			else pstmt.setString(5, "/upload/"+bf.getB_file2());
			if(bf.getB_file3_name()==null) pstmt.setNull(6, java.sql.Types.NULL);
			else pstmt.setString(6, bf.getB_file3_name());
			if(bf.getB_file3()==null) pstmt.setNull(7, java.sql.Types.NULL);
			else pstmt.setString(7, "/upload/"+bf.getB_file3());
			result = pstmt.executeUpdate();
		} catch(Exception err) {
			System.out.println("insertBoardFile() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	
	public int updateNotice(Notice n) {
		int result = 0;
		String sql = "update BOARD set title=?, content=? where b_id=?";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, n.getTitle());
			pstmt.setString(2, n.getContent());
			pstmt.setInt(3, n.getB_id());
			result = pstmt.executeUpdate();
		} catch(Exception err) {
			System.out.println("updateNotice() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int updateHomework(Homework h) {
		int result = 0;
		String sql = "update BOARD set title=?, content=?, duedate=? where b_id=?";
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, h.getTitle());
			pstmt.setString(2, h.getContent());
			pstmt.setLong(3, h.getDuedate());
			pstmt.setInt(4, h.getB_id());
			result = pstmt.executeUpdate();
		} catch(Exception err) {
			System.out.println("updateHomework() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int updateBoardFile(BoardFile bf, boolean f1, boolean f2, boolean f3) {
		int result = 0;
		String updateColumn = "";
		int cntColumn = 1;
		if(f1) updateColumn += "b_file1_name=?, b_file1=?, ";
		if(f2) updateColumn += "b_file2_name=?, b_file2=?, ";
		if(f3) updateColumn += "b_file3_name=?, b_file3=?, ";
		String sql = "update BOARD_File set "+ updateColumn +"b_id=? where b_id=?";
		System.out.println("보드파일 수정 쿼리문 : "+sql);
		try {
			conn = pool.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			if(f1) {
				System.out.println("1시작"+cntColumn);
				pstmt.setString(cntColumn++, bf.getB_file1_name());
				pstmt.setString(cntColumn++, bf.getB_file1());
				System.out.println("1끝"+cntColumn);
			}
			if(f2) {
				System.out.println("2시작"+cntColumn);
				pstmt.setString(cntColumn++, bf.getB_file2_name());
				pstmt.setString(cntColumn++, bf.getB_file2());
				System.out.println("2끝"+cntColumn);
			}
			if(f3) {
				System.out.println("3시작"+cntColumn);
				pstmt.setString(cntColumn++, bf.getB_file3_name());
				pstmt.setString(cntColumn++, bf.getB_file3());
				System.out.println("3끝"+cntColumn);
			}
			pstmt.setInt(cntColumn++, bf.getB_id());
			pstmt.setInt(cntColumn, bf.getB_id());
			System.out.println("최종"+cntColumn);
			result = pstmt.executeUpdate();
			System.out.println("결과 : "+result);
		} catch(Exception err) {
			System.out.println("updateBoardFile() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int deleteBoard(int b_id) {
		int result = 0;
		String sql = "delete from BOARD where b_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("deleteBoard() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	
	public int deleteBoardFile(int b_id) {
		int result = 0;
		String sql = "delete from BOARD_FILE where b_id=?";
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("deleteBoardFile() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	public int boardViewCntUp(int b_id) {
		int result = 0;
		try {
			String sql = "update BOARD set view_cnt=view_cnt+1 where b_id=?";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("boardViewCntUp() 에러 : "+e);
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
}
