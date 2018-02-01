package model;

import java.util.List;

public class Notice {
	private int b_id;
	private int std_id;
	private String title;
	private String content;
	private long b_datetime;
	private int view_cnt;
	private int replies_cnt;
	private List<BoardFile> files;
	
	
	public void setNotice(int b_id, int std_id, String title, String content, long b_datetime, int view_cnt, int replies_cnt) {
		setB_id(b_id);
		setStd_id(std_id);
		setTitle(title);
		setContent(content);
		setB_datetime(b_datetime);
		setView_cnt(view_cnt);
		setReplies_cnt(replies_cnt);
	}
	
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public int getStd_id() {
		return std_id;
	}
	public void setStd_id(int std_id) {
		this.std_id = std_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getB_datetime() {
		return b_datetime;
	}
	public void setB_datetime(long b_datetime) {
		this.b_datetime = b_datetime;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public int getReplies_cnt() {
		return replies_cnt;
	}
	public void setReplies_cnt(int replies_cnt) {
		this.replies_cnt = replies_cnt;
	}
	public List<BoardFile> getFiles() {
		return files;
	}

	public void setFiles(List<BoardFile> files) {
		this.files = files;
	}
}
