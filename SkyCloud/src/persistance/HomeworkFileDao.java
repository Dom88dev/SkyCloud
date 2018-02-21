package persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.HomeworkFile;

public class HomeworkFileDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public HomeworkFileDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception err) {
			System.out.println("HomeworkFileDao() 오류 : "+err);
		}
	}
	
	public List<HomeworkFile> getHFiles(int b_id) {
		ArrayList<HomeworkFile> list = new ArrayList<>();
		try {
			String sql = "select * from HOMEWORKFILE where b_id=?";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				HomeworkFile hf = new HomeworkFile();
				hf.setB_id(b_id);
				hf.setEmail(rs.getString("email"));
				hf.setHw_datetime(rs.getLong("hw_datetime"));
				hf.setHw_file(rs.getString("hw_file"));
				hf.setHw_file_name(rs.getString("hw_file_name"));
				list.add(hf);
			}
				
		} catch(Exception err) {
			System.out.println("getHFiles() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	public int uploadHomework(HomeworkFile hf) {
		int result = 0;
		try {
			String sql = "insert into HOMEWORKFILE(b_id, email, hw_file_name, hw_file, hw_datetime) values(?, ?, ?, ?, ?)";
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hf.getB_id());
			pstmt.setString(2, hf.getEmail());
			pstmt.setString(3, hf.getHw_file_name());
			pstmt.setString(4, hf.getHw_file());
			pstmt.setLong(5, System.currentTimeMillis());
			result = pstmt.executeUpdate();
			
		} catch(Exception err) {
			System.out.println("uploadHomework() 에러 : "+err);
			err.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}
}
