package model;

public class Apply {
	private int apply_id;
	private String email;
	private int std_id;
	private String apply_status;
	private String apply_content;
	private long apply_datetime;
	
	public void setApply(int appliy_id, String email, int std_id, String apply_status, String apply_content, long apply_datetime) {
		setApply_id(appliy_id);
		setEmail(email);
		setStd_id(std_id);
		setApply_status(apply_status);
		setApply_content(apply_content);
		setApply_datetime(apply_datetime);
	}
	
	public int getApply_id() {
		return apply_id;
	}
	public void setApply_id(int apply_id) {
		this.apply_id = apply_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getStd_id() {
		return std_id;
	}
	public void setStd_id(int std_id) {
		this.std_id = std_id;
	}
	public String getApply_status() {
		return apply_status;
	}
	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}
	public String getApply_content() {
		return apply_content;
	}
	public void setApply_content(String apply_content) {
		this.apply_content = apply_content;
	}
	public long getApply_datetime() {
		return apply_datetime;
	}
	public void setApply_datetime(long apply_datetime) {
		this.apply_datetime = apply_datetime;
	}
	
}
