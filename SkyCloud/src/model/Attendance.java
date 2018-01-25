package model;

import java.sql.Date;

public class Attendance {
	private int atd_id;
	private Date atd_date;
	private String atd_status;
	private String email;
	private int std_id;
	
	public void setAttendance(int atdId, Date atdDate, String atdStatus, String email, int stdId){
		setAtd_id(atdId);
		setAtd_date(atdDate);
		setAtd_status(atdStatus);
		setEmail(email);
		setStd_id(stdId);
	}
	
	public int getAtd_id() {
		return atd_id;
	}
	public void setAtd_id(int atd_id) {
		this.atd_id = atd_id;
	}
	public Date getAtd_date() {
		return atd_date;
	}
	public void setAtd_date(Date atd_date) {
		this.atd_date = atd_date;
	}
	public String getAtd_status() {
		return atd_status;
	}
	public void setAtd_status(String atd_status) {
		this.atd_status = atd_status;
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
	
	
}
