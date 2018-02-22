package model;

import java.sql.Date;

public class Member {
	private String email;
	private String pw;
	private String name;
	private String tel;
	private String gender;
	private Date born;
	
	
	public void setMember(String email, String pw, String name, String tel, String gender, Date born) {
		setEmail(email);
		setPw(pw);
		setName(name);
		setTel(tel);
		setGender(gender);
		setBorn(born);
	}
	
	
	


	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Date getBorn() {
		return born;
	}
	public void setBorn(Date born) {
		this.born = born;
	}
}
