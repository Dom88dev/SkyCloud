package model;

public class Replies {
	private int rp_id;
	private int b_id;
	private int rp_pos;
	private int rp_depth;
	private String rp_content;
	private long rp_datetime;
	private String rp_writer;
	private String rp_reciever;
	private String writer;//작성자 닉네임
	private String reciever;//댓글대상자 닉네임
	
	public int getRp_id() {
		return rp_id;
	}
	public void setRp_id(int rp_id) {
		this.rp_id = rp_id;
	}
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public int getRp_pos() {
		return rp_pos;
	}
	public void setRp_pos(int rp_pos) {
		this.rp_pos = rp_pos;
	}
	public int getRp_depth() {
		return rp_depth;
	}
	public void setRp_depth(int rp_depth) {
		this.rp_depth = rp_depth;
	}
	public String getRp_content() {
		return rp_content;
	}
	public void setRp_content(String rp_content) {
		this.rp_content = rp_content;
	}
	public long getRp_datetime() {
		return rp_datetime;
	}
	public void setRp_datetime(long rp_datetime) {
		this.rp_datetime = rp_datetime;
	}
	public String getRp_writer() {
		return rp_writer;
	}
	public void setRp_writer(String rp_writer) {
		this.rp_writer = rp_writer;
	}
	public String getRp_reciever() {
		return rp_reciever;
	}
	public void setRp_reciever(String rp_reciever) {
		this.rp_reciever = rp_reciever;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReciever() {
		return reciever;
	}
	public void setReciever(String reciever) {
		this.reciever = reciever;
	}
}
