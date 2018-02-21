package model;

public class HomeworkFile {
	private int b_id;
	private String email;
	private String hw_file_name;
	private String hw_file;
	private long hw_datetime;
	private String name;
	
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHw_file_name() {
		return hw_file_name;
	}
	public void setHw_file_name(String hw_file_name) {
		this.hw_file_name = hw_file_name;
	}
	public String getHw_file() {
		return hw_file;
	}
	public void setHw_file(String hw_file) {
		this.hw_file = hw_file;
	}
	public long getHw_datetime() {
		return hw_datetime;
	}
	public void setHw_datetime(long hw_datetime) {
		this.hw_datetime = hw_datetime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
